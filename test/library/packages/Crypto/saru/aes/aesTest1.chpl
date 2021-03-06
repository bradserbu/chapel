proc main(){
  use Crypto;

  /* Create AES instance with the version required */
  var a = new AES(256, "cbc");

  /* Key Generation phase starts */
  var salt = new CryptoBuffer("random_salt");
  var hash = new Hash("SHA256");
  var k = new KDF(a.getByteSize(), 1000, hash);
  var key = k.passKDF("random_key", salt);
  writeln("Generated Key: ", key.toHex());
  /* Key Generation phase ends */

  /* IV is manipulated to return the same encryption on every run (for testing purposes) */
  var iv = new CryptoBuffer("random_iv_asdfiljhkalsmvncbhdhfu");
  writeln("Generated IV: ", iv.toHex());

  /* The message to be encrypted */
  var msg = new CryptoBuffer("foo_bar");
  writeln("Original Message: ", msg.toHex());

  /* Encrypt the message using the key and IV */
  var ct = a.encrypt(msg, key, iv);
  writeln("Obtained Ciphertext: ", ct.toHex());

  /* Decrypt the message using the key and IV */
  var orig = a.decrypt(ct, key, iv);
  writeln("Obtained Plaintext: ", orig.toHex());

  /* Clean up allocated classes */
  delete orig;
  delete ct;
  delete msg;
  delete iv;
  delete key;
  delete k;
  delete hash;
  delete salt;
  delete a;
}
