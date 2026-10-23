package com.example.super_secure_login;

import org.junit.Assert;
import org.junit.Test;

public class TestPasswordHash {
    @Test
    public void testPasswordHash() throws Exception {
        String hashedPassword = PasswordHashing.hashWithSalt("test1234");
        Assert.assertTrue(PasswordHashing.verifyPasswordHash("test1234", hashedPassword));
        System.out.println("Hash verification with salt successful: " + hashedPassword);
    }

    @Test
    public void testPasswordPBKDF2() throws Exception {
        String hashedPassword = PasswordHashing.hashWithPBKDF2("test1234");
        Assert.assertTrue(PasswordHashing.verifyPasswordPBKDF2("test1234", hashedPassword));
        System.out.println("Hash verification with PKDF2 successful: " + hashedPassword);
    }

    @Test
    public void testBcrypt() {
        String hashedPassword = PasswordHashing.hashWithBcrypt(("test1234"));
        Assert.assertTrue(PasswordHashing.verifyBcrypt("test1234", hashedPassword));
        System.out.println("Hash verification with Bcrypt successful: " + hashedPassword);
    }

    @Test
    public void testScrypt() {
        String hashedPassword = PasswordHashing.hashWithScrypt(("test1234"));
        Assert.assertTrue(PasswordHashing.verifyScrypt("test1234", hashedPassword));
        System.out.println("Hash verification with Scrypt successful: " + hashedPassword);
    }

    @Test
    public void testPasswordArgon2() {
        String hashedPassword = PasswordHashing.hashWithArgon2("test1234");
        Assert.assertTrue(PasswordHashing.verifyArgon2("test1234", hashedPassword));
        System.out.println("Hash verification with Argon2 successful: " + hashedPassword);
    }
}
