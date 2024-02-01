# RSAの前提知識1

## フェルマーの小定理

<div class="theorem">
  <div class="caption">
    フェルマーの小定理
  </div>

$p$を素数，$a$を整数とすると
  <figure>
  <figcaption class="math-label" id="eq-fermat" style="top:0.7em"></figcaption>

  $$
      a^p \equiv a \pmod{p}
  $$

  </figure>

ここで$a$と$p$を互いに素とした場合
$$
  a^{p-1} \equiv 1 \pmod{p}
$$

</div>

これを数学的帰納法で証明する．まず，$a = 1$のときは明らかに正しい．
次に整数$m$を用いた$(m+1)^p$について考えると
$$
 (m + 1) ^p = m^p + _pC_1m^{p-1} + _pC_{2}m^{p-1} + \ldots + _{p}C_{p-1}m + 1
$$
ここで
$$
  _pC_k = \frac{p(p-1)\cdots(p - k + 1)}
  {k(k-1)\cdots 1} \\
$$
は$p$が素数であるため$p$で約分できず，$p$の倍数であるから
$$
  (m + 1)^p \equiv m^p + 1 \pmod{p}
$$
となる．
ここでフェルマーの小定理が$a = m$の場合に成り立つとすると，$m^p \equiv m \pmod{p}$より$m^p + 1 \equiv m + 1 \pmod{p}$だから，
$$
  (m + 1)^p \equiv m + 1 \pmod{p}
$$
つまり，$a = m + 1$でも成り立つことが分かり，数学的帰納法によって証明される．<a href="#eq-fermat" data-ref="eq"></a>より，

# rsaクレートを使ってみよう

公開鍵を用いて暗号化したデータを秘密鍵を用いて復号してみる．<a href="#code-rsa-example" data-ref="code"></a>はrsaクレートのexampleである．

- 秘密鍵をOS乱数によって生成する．
- 秘密鍵から公開鍵を生成する．
- 公開鍵によって`data`を暗号化し，暗号化したデータを秘密鍵によって復号化する．

<figure>
<figcaption id="code-rsa-example">rsaクレートのexample</figcaption>

```rust
use rsa::{Pkcs1v15Encrypt, RsaPrivateKey, RsaPublicKey};

let mut rng = rand::thread_rng();
let bits = 2048;
let priv_key = RsaPrivateKey::new(&mut rng, bits).expect("failed to generate a key");
let pub_key = RsaPublicKey::from(&priv_key);

// Encrypt
let data = b"hello world";
let enc_data = pub_key.encrypt(&mut rng, Pkcs1v15Encrypt, &data[..]).expect("failed to encrypt");
assert_ne!(&data[..], &enc_data[..]);

// Decrypt
let dec_data = priv_key.decrypt(Pkcs1v15Encrypt, &enc_data).expect("failed to decrypt");
assert_eq!(&data[..], &dec_data[..]);
```

</figure>

もし`RsaPrivateKey::new`による鍵の生成が遅い場合はリリースビルドを行う．

## 表

これらを<a href="#table-duty-cycle" data-ref="tbl"></a> に示す.
また<a href="#table-nanika-hyou" data-ref="tbl"></a>は何かの表である．

<figure>
<figcaption id="table-nanika-hyou">なにかしらの表</figcaption>

| 1          | 2 | 他より長い項目 | ほかよりかなりながいこうもく |
|----------------|-------|---------------------|--------------------------------|
| 15.6           | 十    | ああ          | 22.3                           |
| 12.4           | 一    | ああ             |     あ    |
| ここ | 五    | $e = mc^2$ | 12.6|

</figure>

<table>
  <caption id="table-duty-cycle">デューティー比と H/L 期間</caption>
  <thead>
    <tr>
      <th></th> <th>14 % での期間 [s]</th> <th>10 % での期間 [s]</th> <th>6 % での期間 [s]</th>
    </tr>
  </thead>
  <tbody class="right">
    <tr>
      <th>H 期間</th> <td>2.1</td> <td>1.5</td> <td>0.9</td>
    </tr>
    <tr>
      <th>L 期間</th> <td>12.9</td> <td>13.5</td> <td>14.1</td>
    </tr>
  </tbody>
</table>

## 脚注

Rustというなまえはさび菌にちなんで付けられた．<span class="footnote">
[rust](https://www.reddit.com/r/rust/comments/27jvdt/internet_archaeology_the_definitive_endall_source/)
</span>

## 引用

> 引用された文章

<div class="info">
  <div class="caption">INFO</div>
  情報の内容
</div>

<div class="warn">
  <div class="caption">WARN</div>
  警告の内容
</div>

<div class="theorem">
  <div class="caption">HOGE HOGE の定理</div>
  定理の内容
</div>

# 参考文献

<ol class="cite-items">
  <li id="cite-rust-wiki">Rust(プログラミング言語) Wikipedia</li>
</ol>
