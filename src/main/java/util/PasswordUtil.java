package util;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordUtil {
    private static final int ITERATIONS = 100000; // Number of iterations
    private static final int KEY_LENGTH = 256; // Key length in bits
    private static final String ALGORITHM = "PBKDF2WithHmacSHA256";

    // Hash password with a random salt
    public static String hashPassword(String password) throws Exception {
        // Generate a random salt
        byte[] salt = new byte[16];
        SecureRandom random = new SecureRandom();
        random.nextBytes(salt);

        // Create hash
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt, ITERATIONS, KEY_LENGTH);
        SecretKeyFactory skf = SecretKeyFactory.getInstance(ALGORITHM);
        byte[] hash = skf.generateSecret(spec).getEncoded();

        // Combine salt and hash, encode to Base64
        byte[] saltAndHash = new byte[salt.length + hash.length];
        System.arraycopy(salt, 0, saltAndHash, 0, salt.length);
        System.arraycopy(hash, 0, saltAndHash, salt.length, hash.length);
        return Base64.getEncoder().encodeToString(saltAndHash);
    }

    // Verify password
    public static boolean verifyPassword(String password, String storedHash) throws Exception {
        // Decode stored hash
        byte[] saltAndHash = Base64.getDecoder().decode(storedHash);
        byte[] salt = new byte[16];
        byte[] hash = new byte[saltAndHash.length - salt.length];
        System.arraycopy(saltAndHash, 0, salt, 0, salt.length);
        System.arraycopy(saltAndHash, salt.length, hash, 0, hash.length);

        // Compute hash of provided password
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt, ITERATIONS, KEY_LENGTH);
        SecretKeyFactory skf = SecretKeyFactory.getInstance(ALGORITHM);
        byte[] testHash = skf.generateSecret(spec).getEncoded();

        // Compare hashes
        return constantTimeEquals(hash, testHash);
    }

    // Constant-time comparison to prevent timing attacks
    private static boolean constantTimeEquals(byte[] a, byte[] b) {
        if (a.length != b.length) return false;
        int result = 0;
        for (int i = 0; i < a.length; i++) {
            result |= a[i] ^ b[i];
        }
        return result == 0;
    }
}