class MD5Checksum extends Object;

var private GUID StaticHashValue;
var private array<byte> StaticData;

//=============================================================================
// Instant hash functions - probably not suitable for long input data
//=============================================================================
 
static final function GUID GetStringHash(string In)
{
  local int StrLen, i;
 
  StrLen = Len(In);
  default.StaticData.Length = StrLen;
  for (i = 0; i < StrLen; i++) {
    default.StaticData[i] = Asc(Mid(In, i, 1));
  }
  StaticProcessChunks();
  return default.StaticHashValue;
}
 
static final function string GetStringHashString(string In)
{
  local int StrLen, i;
 
  StrLen = Len(In);
  default.StaticData.Length = StrLen;
  for (i = 0; i < StrLen; i++) {
    default.StaticData[i] = Asc(Mid(In, i, 1));
  }
  StaticProcessChunks();
  return LittleEndianToHex(default.StaticHashValue.A)
      $ LittleEndianToHex(default.StaticHashValue.B)
      $ LittleEndianToHex(default.StaticHashValue.C)
      $ LittleEndianToHex(default.StaticHashValue.D);
}
 
static final function GUID GetArrayHash(array<byte> In)
{
  default.StaticData = In;
  StaticProcessChunks();
  return default.StaticHashValue;
}
 
static final function string GetArrayHashString(array<byte> In)
{
  default.StaticData = In;
  StaticProcessChunks();
  return LittleEndianToHex(default.StaticHashValue.A)
      $ LittleEndianToHex(default.StaticHashValue.B)
      $ LittleEndianToHex(default.StaticHashValue.C)
      $ LittleEndianToHex(default.StaticHashValue.D);
}
 
static final function string GetHashString(GUID Hash)
{
  return LittleEndianToHex(Hash.A) $ LittleEndianToHex(Hash.B)
      $ LittleEndianToHex(Hash.C) $ LittleEndianToHex(Hash.D);
}
 
//=============================================================================
// Internal stuff for static instant hashing functions
//=============================================================================
 
static final function string LittleEndianToHex(int i)
{
  const hex = "0123456789abcdef";
 
  return Mid(hex, i >> 4 & 0xf, 1) $ Mid(hex, i & 0xf, 1)
      $ Mid(hex, i >> 12 & 0xf, 1) $ Mid(hex, i >> 8 & 0xf, 1)
      $ Mid(hex, i >> 20 & 0xf, 1) $ Mid(hex, i >> 16 & 0xf, 1)
      $ Mid(hex, i >> 28 & 0xf, 1) $ Mid(hex, i >> 24 & 0xf, 1);
}
 
static final function StaticProcessChunks()
{
  local int i;
  local int A, B, C, D;
  local int W[16];
 
  i = default.StaticData.Length;
  if (i % 64 < 56)
    default.StaticData.Length = default.StaticData.Length + 64 - i % 64;
  else
    default.StaticData.Length = default.StaticData.Length + 128 - i % 64;
  default.StaticData[i] = 0x80;
  default.StaticData[default.StaticData.Length - 4] = (i >>> 29);
  default.StaticData[default.StaticData.Length - 5] = (i >>> 21);
  default.StaticData[default.StaticData.Length - 6] = (i >>> 13);
  default.StaticData[default.StaticData.Length - 7] = (i >>>  5);
  default.StaticData[default.StaticData.Length - 8] = (i <<   3);
 
  default.StaticHashValue.A = 0x67452301;
  default.StaticHashValue.B = 0xEFCDAB89;
  default.StaticHashValue.C = 0x98BADCFE;
  default.StaticHashValue.D = 0x10325476;
 
  while (default.StaticData.Length > 0) {
    for (i = 0; i < 16; i++) {
      W[i] = (default.StaticData[i * 4 + 3] << 24)
          | (default.StaticData[i * 4 + 2] << 16)
          | (default.StaticData[i * 4 + 1] << 8)
          | default.StaticData[i * 4];
    }
 
    // initialize hash value for this chunk
    A = default.StaticHashValue.A;
    B = default.StaticHashValue.B;
    C = default.StaticHashValue.C;
    D = default.StaticHashValue.D;
 
    // round 1
    A += (D ^ (B & (C ^ D))) + W[ 0] + 0xD76AA478;   A = B + (A <<  7 | A >>>  -7);
    D += (C ^ (A & (B ^ C))) + W[ 1] + 0xE8C7B756;   D = A + (D << 12 | D >>> -12);
    C += (B ^ (D & (A ^ B))) + W[ 2] + 0x242070DB;   C = D + (C << 17 | C >>> -17);
    B += (A ^ (C & (D ^ A))) + W[ 3] + 0xC1BDCEEE;   B = C + (B << 22 | B >>> -22);
 
    A += (D ^ (B & (C ^ D))) + W[ 4] + 0xF57C0FAF;   A = B + (A <<  7 | A >>>  -7);
    D += (C ^ (A & (B ^ C))) + W[ 5] + 0x4787C62A;   D = A + (D << 12 | D >>> -12);
    C += (B ^ (D & (A ^ B))) + W[ 6] + 0xA8304613;   C = D + (C << 17 | C >>> -17);
    B += (A ^ (C & (D ^ A))) + W[ 7] + 0xFD469501;   B = C + (B << 22 | B >>> -22);
 
    A += (D ^ (B & (C ^ D))) + W[ 8] + 0x698098D8;   A = B + (A <<  7 | A >>>  -7);
    D += (C ^ (A & (B ^ C))) + W[ 9] + 0x8B44F7AF;   D = A + (D << 12 | D >>> -12);
    C += (B ^ (D & (A ^ B))) + W[10] + 0xFFFF5BB1;   C = D + (C << 17 | C >>> -17);
    B += (A ^ (C & (D ^ A))) + W[11] + 0x895CD7BE;   B = C + (B << 22 | B >>> -22);
 
    A += (D ^ (B & (C ^ D))) + W[12] + 0x6B901122;   A = B + (A <<  7 | A >>>  -7);
    D += (C ^ (A & (B ^ C))) + W[13] + 0xFD987193;   D = A + (D << 12 | D >>> -12);
    C += (B ^ (D & (A ^ B))) + W[14] + 0xA679438E;   C = D + (C << 17 | C >>> -17);
    B += (A ^ (C & (D ^ A))) + W[15] + 0x49B40821;   B = C + (B << 22 | B >>> -22);
 
    // round 2
    A += (C ^ (D & (B ^ C))) + W[ 1] + 0xF61E2562;   A = B + (A <<  5 | A >>>  -5);
    D += (B ^ (C & (A ^ B))) + W[ 6] + 0xC040B340;   D = A + (D <<  9 | D >>>  -9);
    C += (A ^ (B & (D ^ A))) + W[11] + 0x265E5A51;   C = D + (C << 14 | C >>> -14);
    B += (D ^ (A & (C ^ D))) + W[ 0] + 0xE9B6C7AA;   B = C + (B << 20 | B >>> -20);
 
    A += (C ^ (D & (B ^ C))) + W[ 5] + 0xD62F105D;   A = B + (A <<  5 | A >>>  -5);
    D += (B ^ (C & (A ^ B))) + W[10] + 0x02441453;   D = A + (D <<  9 | D >>>  -9);
    C += (A ^ (B & (D ^ A))) + W[15] + 0xD8A1E681;   C = D + (C << 14 | C >>> -14);
    B += (D ^ (A & (C ^ D))) + W[ 4] + 0xE7D3FBC8;   B = C + (B << 20 | B >>> -20);
 
    A += (C ^ (D & (B ^ C))) + W[ 9] + 0x21E1CDE6;   A = B + (A <<  5 | A >>>  -5);
    D += (B ^ (C & (A ^ B))) + W[14] + 0xC33707D6;   D = A + (D <<  9 | D >>>  -9);
    C += (A ^ (B & (D ^ A))) + W[ 3] + 0xF4D50D87;   C = D + (C << 14 | C >>> -14);
    B += (D ^ (A & (C ^ D))) + W[ 8] + 0x455A14ED;   B = C + (B << 20 | B >>> -20);
 
    A += (C ^ (D & (B ^ C))) + W[13] + 0xA9E3E905;   A = B + (A <<  5 | A >>>  -5);
    D += (B ^ (C & (A ^ B))) + W[ 2] + 0xFCEFA3F8;   D = A + (D <<  9 | D >>>  -9);
    C += (A ^ (B & (D ^ A))) + W[ 7] + 0x676F02D9;   C = D + (C << 14 | C >>> -14);
    B += (D ^ (A & (C ^ D))) + W[12] + 0x8D2A4C8A;   B = C + (B << 20 | B >>> -20);
 
    // round 3
    A += (B ^ C ^ D) + W[ 5] + 0xFFFA3942;    A = B + (A <<  4 | A >>>  -4);
    D += (A ^ B ^ C) + W[ 8] + 0x8771F681;    D = A + (D << 11 | D >>> -11);
    C += (D ^ A ^ B) + W[11] + 0x6D9D6122;    C = D + (C << 16 | C >>> -16);
    B += (C ^ D ^ A) + W[14] + 0xFDE5380C;    B = C + (B << 23 | B >>> -23);
 
    A += (B ^ C ^ D) + W[ 1] + 0xA4BEEA44;    A = B + (A <<  4 | A >>>  -4);
    D += (A ^ B ^ C) + W[ 4] + 0x4BDECFA9;    D = A + (D << 11 | D >>> -11);
    C += (D ^ A ^ B) + W[ 7] + 0xF6BB4B60;    C = D + (C << 16 | C >>> -16);
    B += (C ^ D ^ A) + W[10] + 0xBEBFBC70;    B = C + (B << 23 | B >>> -23);
 
    A += (B ^ C ^ D) + W[13] + 0x289B7EC6;    A = B + (A <<  4 | A >>>  -4);
    D += (A ^ B ^ C) + W[ 0] + 0xEAA127FA;    D = A + (D << 11 | D >>> -11);
    C += (D ^ A ^ B) + W[ 3] + 0xD4EF3085;    C = D + (C << 16 | C >>> -16);
    B += (C ^ D ^ A) + W[ 6] + 0x04881D05;    B = C + (B << 23 | B >>> -23);
 
    A += (B ^ C ^ D) + W[ 9] + 0xD9D4D039;    A = B + (A <<  4 | A >>>  -4);
    D += (A ^ B ^ C) + W[12] + 0xE6DB99E5;    D = A + (D << 11 | D >>> -11);
    C += (D ^ A ^ B) + W[15] + 0x1FA27CF8;    C = D + (C << 16 | C >>> -16);
    B += (C ^ D ^ A) + W[ 2] + 0xC4AC5665;    B = C + (B << 23 | B >>> -23);
 
    // round 4
    A += (C ^ (B | ~D)) + W[ 0] + 0xF4292244;     A = B + (A <<  6 | A >>>  -6);
    D += (B ^ (A | ~C)) + W[ 7] + 0x432AFF97;     D = A + (D << 10 | D >>> -10);
    C += (A ^ (D | ~B)) + W[14] + 0xAB9423A7;     C = D + (C << 15 | C >>> -15);
    B += (D ^ (C | ~A)) + W[ 5] + 0xFC93A039;     B = C + (B << 21 | B >>> -21);
 
    A += (C ^ (B | ~D)) + W[12] + 0x655B59C3;     A = B + (A <<  6 | A >>>  -6);
    D += (B ^ (A | ~C)) + W[ 3] + 0x8F0CCC92;     D = A + (D << 10 | D >>> -10);
    C += (A ^ (D | ~B)) + W[10] + 0xFFEFF47D;     C = D + (C << 15 | C >>> -15);
    B += (D ^ (C | ~A)) + W[ 1] + 0x85845dd1;     B = C + (B << 21 | B >>> -21);
 
    A += (C ^ (B | ~D)) + W[ 8] + 0x6FA87E4F;     A = B + (A <<  6 | A >>>  -6);
    D += (B ^ (A | ~C)) + W[15] + 0xFE2CE6E0;     D = A + (D << 10 | D >>> -10);
    C += (A ^ (D | ~B)) + W[ 6] + 0xA3014314;     C = D + (C << 15 | C >>> -15);
    B += (D ^ (C | ~A)) + W[13] + 0x4E0811A1;     B = C + (B << 21 | B >>> -21);
 
    A += (C ^ (B | ~D)) + W[ 4] + 0xF7537E82;     A = B + (A <<  6 | A >>>  -6);
    D += (B ^ (A | ~C)) + W[11] + 0xBD3AF235;     D = A + (D << 10 | D >>> -10);
    C += (A ^ (D | ~B)) + W[ 2] + 0x2AD7D2BB;     C = D + (C << 15 | C >>> -15);
    B += (D ^ (C | ~A)) + W[ 9] + 0xEB86D391;     B = C + (B << 21 | B >>> -21);
 
    // add this chunk's hash to result so far
    default.StaticHashValue.A += A;
    default.StaticHashValue.B += B;
    default.StaticHashValue.C += C;
    default.StaticHashValue.D += D;
 
    default.StaticData.Remove(0, 64);
  }
}

defaultproperties
{
}
