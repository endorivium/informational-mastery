package de.fhro.inf.its.uebung2;

import javax.crypto.*;
import javax.crypto.spec.IvParameterSpec;
import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;


public class Encryption {

    private static final String CIPHER_ALGORITHM_ECB = "AES/ECB/PKCS5Padding";
    private static final String CIPHER_ALGORITHM_CBC = "AES/CBC/PKCS5Padding";
    private static final String ALGORITHM = "AES";
    private static final int IV_Length = 16;  //AES block size is 16 bytes
    private static final int KEY_SIZE = 256;

    private Encryption() {
    }

    /**
     * Generate a symmetric key with selected algorithm and key size.
     *
     * @return symmetric SecretKey
     */
    public static SecretKey generateKey() throws NoSuchAlgorithmException {
        KeyGenerator keygen = KeyGenerator.getInstance(ALGORITHM);  // specify algorithm for key generation
        keygen.init(KEY_SIZE, new SecureRandom());  // set cipher strength and cryptographically secure RNG

        return keygen.generateKey();
    }

    /**
     * Encrypt data with given key.
     *
     * @param key  SecretKey, generated with generateKey
     * @param data byte Array to encrypt
     * @return encrypted data
     */
    public static byte[] encryptECB(SecretKey key, byte[] data) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM_ECB);  // instantiate a Cipher object with key/mode/padding
        cipher.init(Cipher.ENCRYPT_MODE, key);

        return cipher.doFinal(data);  // encrypt all data in one step
    }

    /**
     * Save key base64 encoded in a file.
     *
     * @param destFile destination filename
     * @param key      SecretKey to save
     */
    public static void saveKey(String destFile, SecretKey key) throws IOException {
        FileUtils.writeToFileBase64(destFile, key.getEncoded());
    }

    public static byte[] createIV (){
        byte[] iv = new byte[IV_Length]; // AES block size is 16 bytes
        SecureRandom random = new SecureRandom();
        random.nextBytes(iv);
        return iv;
    }

    public static byte[] encryptCBC(SecretKey key, byte[] data, byte[] iv) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidAlgorithmParameterException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM_CBC);  // instantiate a Cipher object with key/mode/padding
        cipher.init(Cipher.ENCRYPT_MODE, key, new IvParameterSpec(iv));

        return cipher.doFinal(data);  // encrypt all data in one step
    }

    public static byte[] concatenateIvAndData(byte[] iv, byte[] encryptedData){
        byte[] encryptedDataWithIv = new byte[iv.length + encryptedData.length];
        System.arraycopy(iv, 0, encryptedDataWithIv, 0, iv.length);
        System.arraycopy(encryptedData, 0, encryptedDataWithIv, iv.length, encryptedData.length);
        return encryptedDataWithIv;
    }
}
