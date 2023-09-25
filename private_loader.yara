rule win_privateloader : loader 
{
  meta:
    author    = "andretavare5"
    org       = "BitSight"
    date      = "2022-06-06"
    md5       = "8f70a0f45532261cb4df2800b141551d"
    reference = "https://tavares.re/blog/2022/06/06/hunting-privateloader-pay-per-install-service"
    license   = "CC BY-NC-SA 4.0"
    
  strings:
    $x   = {66 0F EF (4?|8?)} // pxor xmm(1/0) - str chunk decryption
    $s   = "Content-Type: application/x-www-form-urlencoded\r\n" wide ascii
    $ua1 = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" wide ascii
    $ua2 = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36" wide ascii
                              
  condition:
    uint16(0) == 0x5A4D and // MZ
    $s and
    any of ($ua*) and
    #x > 100
}
