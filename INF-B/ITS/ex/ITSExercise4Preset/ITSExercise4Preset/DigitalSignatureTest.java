package de.fhro.inf.its.exercise;

import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.*;
import java.security.cert.Certificate;
import java.security.cert.CertificateException;
import java.security.spec.InvalidKeySpecException;

import static org.junit.jupiter.api.Assertions.*;

class DigitalSignatureTest {

    @Test
    void testDigitalSignature() throws CertificateException, IOException, NoSuchAlgorithmException, InvalidKeySpecException, SignatureException, InvalidKeyException {
        PrivateKey privateKey = CryptoUtil.getPrivateKey("private.pkcs8");

        byte[] signedData = DigitalSignature.sign("document.txt", privateKey);
        Files.write(Path.of("document.signature"), signedData);

        Certificate cert = CryptoUtil.readCertificate("certificate.pem");
        boolean verified = DigitalSignature.verify("document.txt", "document.txt.sig", cert.getPublicKey());

        assertTrue(verified);
    }
}