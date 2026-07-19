package de.fhro.inf.its.uebung2;

import javax.crypto.*;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;

public class Decryption {

    private static final String CIPHER_ALGORITHM_ECB = "AES/ECB/PKCS5Padding";
    private static final String CIPHER_ALGORITHM_CBC = "AES/CBC/PKCS5Padding";
    private static final String ALGORITHM = "AES";
    private static final int IV_Length = 16;  //AES block size is 16 bytes

    private Decryption() {
    }

    /**
     * Read symmetric key from file and decode it base64.
     *
     * @param inputFile filename
     * @return symmetric SecretKey
     */
    public static SecretKey readKey(String inputFile) throws IOException {
        return new SecretKeySpec(FileUtils.readFromFileBase64(inputFile), ALGORITHM);
    }

    /**
     * Decrypt data with given key.
     *
     * @param key  SecretKey, read with readKey
     * @param data byte Array to decrypt
     * @return decrypted data
     */
    public static byte[] decryptECB(SecretKey key, byte[] data) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM_ECB);
        cipher.init(Cipher.DECRYPT_MODE, key);

        return cipher.doFinal(data);  //decrypt
    }


    public static byte[] decryptCBC(SecretKey key, byte[] encryptedDataWithIv) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException, InvalidAlgorithmParameterException {

        byte[] iv = Arrays.copyOfRange(encryptedDataWithIv, 0, IV_Length);
        Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM_CBC);  // instantiate a Cipher object with key/mode/padding
        cipher.init(Cipher.DECRYPT_MODE, key, new IvParameterSpec(iv));
        byte[] data = Arrays.copyOfRange(encryptedDataWithIv, IV_Length, encryptedDataWithIv.length);

        return cipher.doFinal(data);  //decrypt
    }

}
