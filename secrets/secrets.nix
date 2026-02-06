let
  hana = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEaNh2GVxWz2zLxDa8cMnPtfYQPk1A3xlKKVuKOTNrp2 antonio@hana"
    "age198s694ujjncgae5gctk7x8tcw746nkr39tqj6wg5k2uh8r8a237qnnwgkz"
    "age1nn2vewqrej5sn9lqkh3sf0slgj7cemmlre03l286vx9cu59k9u9qsyttcd"
  ];
in
{
  "secret1.age".publicKeys = hana;
  "secret2.age".publicKeys = hana;
  "secret3.age".publicKeys = hana;
}
