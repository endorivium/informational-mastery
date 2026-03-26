import javax.crypto.*;
import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;


public class Encryption {

    private static final String CIPHER_ALGORITHM_ECB = "AES/ECB/PKCS5Padding";
    private static final String ALGORITHM = "AES";
    private static final int KEY_SIZE = 256;
    private static final int IV_LENGTH = 256;

    private Encryption() {
    }

    /**
     * Generate a symmetric key with selected algorithm and key size.
     *
     * @return symmetric SecretKey
     */
    public static SecretKey generateKey() throws NoSuchAlgorithmException {
        //get key generator based on algorithm and init with given key size
        KeyGenerator keyGenerator = KeyGenerator.getInstance(ALGORITHM);
        //set cipher strength and cryptographically secure RNG
        keyGenerator.init(KEY_SIZE, new SecureRandom());

        //generate and return key
        return keyGenerator.generateKey();
    }

    /**
     * Encrypt data with given key.
     *
     * @param key  SecretKey, generated with generateKey
     * @param data byte Array to encrypt
     * @return encrypted data
     */
    public static byte[] encrypt(SecretKey key, byte[] data) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        Cipher c = Cipher.getInstance(CIPHER_ALGORITHM_ECB);
        c.init(Cipher.ENCRYPT_MODE, key);
        return c.doFinal(data);
    }

    /**
     * Save key base64 encoded in a file.
     *
     * @param destFile destination filename
     * @param key      SecretKey to save
     */
    public static void saveKey(String destFile, SecretKey key) throws IOException {
        byte[] keyData = key.getEncoded();
        FileUtils.writeToFileBase64(destFile, keyData);
    }

    public static byte[] createIV(){
        //TODO
        byte[] iv = new byte[IV_LENGTH];
        return iv;
    }
}
