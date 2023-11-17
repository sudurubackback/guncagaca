package backend.sudurukbackx6.ownerservice.encoder;

public interface Encrypt {
    String encrypt(String password);
    boolean isMatch(String password, String hashed);
}
