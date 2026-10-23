import org.junit.jupiter.api.Test;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

class EncryptionTest {
    @Test
    void testEncryptionAndDecryption() throws IOException, NoSuchAlgorithmException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException, InvalidKeyException {
        byte[] data = FileUtils.readFromFile("mydata.txt");

        SecretKey key = Encryption.generateKey();
        Encryption.saveKey("mykey", key);
        FileUtils.writeToFile("mydata.enc",
                Encryption.encrypt(key, data));



    }
}