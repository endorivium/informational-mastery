package de.fhro.inf.its.exercise;


import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.*;

/**
 * Class to Create and verify a digital signature with the algorithm
 * SHA-512 as hash-function for computing the digest
 * RSA for encryption
 */
public class DigitalSignature {

    /**
     * Sign the contents of a file.
     *
     * @param filename     name of the file to be signed
     * @param signatureKey private key for signing
     * @return signature
     */
    public static byte[] sign(String filename, PrivateKey signatureKey) throws NoSuchAlgorithmException, InvalidKeyException, SignatureException, IOException {
        // init signature with private key for signing
        Signature signature = Signature.getInstance("SHA512withRSA");
        signature.initSign(signatureKey);

        // read data and calculate Hash-value
        byte[] messageBytes = Files.readAllBytes(Paths.get(filename));
        signature.update(messageBytes); // update calculates hash value

        // make signature
        return signature.sign(); // make signature
    }

    /**
     * Verify the signature of a signed file.
     *
     * @param filename    name of the signed file
     * @param sigFilename name of the file where the signature is stored
     * @return true if signature is correct, false if not
     */
    public static boolean verify(String filename, String sigFilename, PublicKey pubKey) throws NoSuchAlgorithmException, InvalidKeyException, IOException, SignatureException {
        // init signature with public key for verifying
        Signature signature = Signature.getInstance("SHA512withRSA");
        signature.initVerify(pubKey);

        // read file and calculate Message Digest
        byte[] messageBytes = Files.readAllBytes(Paths.get(filename));
        signature.update(messageBytes);

        // read the signature from file
        byte[] digitalSignature = Files.readAllBytes(Paths.get(sigFilename));

        // verify the message digests and the signature
        return signature.verify(digitalSignature);
    }
}
