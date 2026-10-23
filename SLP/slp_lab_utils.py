"""Shared helpers for the SLP speech classification labs (02_02, 02_03).

Data: EmoDB (Berlin Database of Emotional Speech), loaded via audb, CC0.
We use the official, speaker-disjoint train / test split shipped with audb.
"""

import os
from pathlib import Path

import joblib
import numpy as np
import pandas as pd
from IPython.display import Audio
from sklearn.preprocessing import StandardScaler

SR = 16000
EMOTIONS = ['neutral', 'anger', 'boredom', 'disgust', 'fear', 'happiness', 'sadness']

# features and embeddings are cached here, outside the repo (override with SLP_CACHE)
CACHE_DIR = Path(os.environ.get('SLP_CACHE', Path.home() / '.cache' / 'slp_labs'))


def load_emodb(version='2.0.0'):
    """Return (train, test) DataFrames with one row per utterance.

    Columns: file, laryngo, emotion, speaker, gender, age, sentence, text, duration.
    """
    import audb

    db = audb.load('emodb', version=version, verbose=False)
    files = db['files'].get()
    speakers = db.misc_tables['speaker'].get()
    sentences = db.schemes['transcription'].labels
    laryngo = {Path(p).name: p for p in db['laryngo.files'].get().index}

    def split(name):
        df = db[f'emotion.categories.{name}.gold_standard'].get()[['emotion']]
        df = df.join(files)
        df = df.join(speakers[['gender', 'age']], on='speaker')
        df = df.rename(columns={'transcription': 'sentence'})
        df['sentence'] = df['sentence'].astype(str)
        df['text'] = df['sentence'].map(sentences)
        df['duration'] = df['duration'].dt.total_seconds()
        df['emotion'] = pd.Categorical(df['emotion'], categories=EMOTIONS)
        df = df.reset_index()
        df['laryngo'] = df['file'].map(lambda p: laryngo[Path(p).name])
        return df[['file', 'laryngo', 'emotion', 'speaker', 'gender', 'age', 'sentence', 'text', 'duration']]

    return split('train'), split('test')


def load_audio(path, sr=SR):
    import librosa

    y, _ = librosa.load(path, sr=sr)
    return y


def play(y, rate=SR):
    # play y as stored: no normalisation, values outside [-1, 1] are clipped
    return Audio(np.clip(y, -1.0, 1.0), rate=rate, normalize=False)


def cached(name, fn, refresh=False):
    """Compute fn() once and store the result in CACHE_DIR/<name>.joblib."""
    path = CACHE_DIR / f'{name}.joblib'
    if path.exists() and not refresh:
        return joblib.load(path)
    result = fn()
    path.parent.mkdir(parents=True, exist_ok=True)
    joblib.dump(result, path)
    return result


def speaker_znorm(X, speakers):
    """Standardise every feature per speaker (removes speaker offsets such as mean F0).

    Uses sklearn's StandardScaler, fitted separately on the recordings of each speaker.
    Speaker normalisation is unsupervised (no labels needed), so it may also be applied to test speakers.
    """
    X = np.asarray(X, dtype=float).copy()
    speakers = np.asarray(speakers)
    for s in np.unique(speakers):
        X[speakers == s] = StandardScaler().fit_transform(X[speakers == s])
    return X
