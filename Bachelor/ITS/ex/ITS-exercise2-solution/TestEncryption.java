package de.fhro.inf.its.uebung2;

import org.junit.jupiter.api.Test;

import javax.crypto.SecretKey;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.logging.Logger;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.fail;

class TestEncryption {
    private static final String INPUT_FILENAME = "test.txt";
    private static final String ENC_FILENAME = "test.enc.txt";
    private static final String KEY_FILENAME = "key.txt";
    private static final Logger logger = Logger.getLogger(TestEncryption.class.getName());

    // This is not a good test setup, but it is simple and easy to understand.
    // In the real world you would most likely test each method in a separate test file and make some integration tests
    // in another file.
    @Test
    void testEncryptionAndDecryption() {
        encryptDataECB();
        decryptDataECB();

        encryptDataCBC();
        decryptDataCBC();
    }

    private void encryptDataECB() {
        try {
            logger.info("Encryption with AES");
            byte[] data = FileUtils.readFromFile(INPUT_FILENAME);
            SecretKey key = Encryption.generateKey();
            byte[] encryptedData = Encryption.encryptECB(key, data);
            FileUtils.writeToFile(ENC_FILENAME, encryptedData);
            Encryption.saveKey(KEY_FILENAME, key);
            logger.info("Encryption successful finished");

        } catch (Exception e) {
            logger.severe("Error in encryption!");
            logger.severe(e.toString());
            fail();
        }
    }

    private void decryptDataECB() {
        try {
            byte[] encryptedData = FileUtils.readFromFile(ENC_FILENAME);
            SecretKey key = Decryption.readKey(KEY_FILENAME);
            byte[] decryptedData = Decryption.decryptECB(key, encryptedData);
            logger.info(() -> "Decrypted File: " + new String(decryptedData));

            byte[] originalData = Files.readAllBytes(Paths.get(INPUT_FILENAME));
            assertArrayEquals(decryptedData, originalData);
            logger.info("Decryption SUCCESSFUL");

        } catch (Exception e) {
            logger.info("error in decryption");
            logger.info(e.toString());

            fail();
        }
    }

    private void encryptDataCBC() {
        try {
            logger.info("Encrypt CBC");
            byte[] data = FileUtils.readFromFile(INPUT_FILENAME);
            SecretKey key = Decryption.readKey(KEY_FILENAME);  //reuse AES Key from ECB
            byte[] iv = Encryption.createIV();
            byte[] encryptedData = Encryption.encryptCBC(key, data, iv);
            byte[] encryptedDataWithIv = Encryption.concatenateIvAndData(iv,encryptedData);
            FileUtils.writeToFileBase64(ENC_FILENAME, encryptedDataWithIv);
            logger.info("Encryption with CBC successful");

        } catch (Exception e) {
            logger.severe("Error in encryption!");
            logger.severe(e.toString());

            fail();
        }
    }

    private void decryptDataCBC() {
        try {
            logger.info("Decrypting...");
            byte[] encryptedDataWithIv = FileUtils.readFromFileBase64(ENC_FILENAME);
            SecretKey key = Decryption.readKey(KEY_FILENAME);
            byte[] decryptedData = Decryption.decryptCBC(key, encryptedDataWithIv);
            logger.info(() -> "Decrypted File: " + new String(decryptedData));
            byte[] originalData = Files.readAllBytes(Paths.get(INPUT_FILENAME));
            assertArrayEquals(decryptedData, originalData);
            logger.info("Decryption SUCCESSFUL");

        } catch (Exception e) {
            logger.info("error in decryption");
            logger.info(e.toString());

            fail();
        }
    }
}
