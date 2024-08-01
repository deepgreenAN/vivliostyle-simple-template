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

# その他

通常の文章．**強調された文章**．*斜体*, ~~訂正された文章~~

<div class="blue font-large">
色付き大の通常，<strong>色付き大の強調</strong>, <em>色付き大の斜体</em>, <del>色付き大の訂正</del>
</div>
<div class="bg-red">
背景色付き通常，<strong>背景色付きの強調</strong>, <em>背景色付きの斜体</em>, <del>背景色付きの訂正</del>
</div>
<div class="under-line text-decoration-red" style="text-decoration-style: dotted;">
下線付き通常，<strong>下線色付きの強調</strong>, <em>下線色付きの斜体</em>, <del>下線色付きの訂正</del>
</div>

<div class="border-yellow" style="border-radius: 10px;">

枠付きの要素

- a
- b

</div>

以下はリストを段組みとしたもの．

<div>
縦二段組リスト(列方向フロー)
</div>
<div class="list-col-3-col border" style="--row-number: 4;">

- あああああああああああああああああ
- b
- c
- d
- e
- f
- g
- h
- i
- j
- k

</div>

<div>
縦二段組リスト(行方向フロー)
</div>
<div class="list-col-3-row border">

<ul>
  <li style="grid-column: 1 / 3">あああああああああああああ</li>
  <li>b</li>
  <li>c</li>
  <li>d</li>
  <li>e</li>
  <li>f</li>
  <li>g</li>
  <li>h</li>
  <li>i</li>
</ul>

</div>

<div>
縦二段組リスト(行方向フロー＋フレックス)
</div>
<div class="list-col-3-row-flex border">

<ul>
  <li style="--account-number:2;">あああああああああああああ</li>
  <li>b</li>
  <li>c</li>
  <li style="--account-number:3;order:1;">いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい</li>
  <li>e</li>
  <li>f</li>
  <li>g</li>
  <li>h</li>
  <li>i</li>
</ul>

</div>

<div>
横二段組リスト(行方向フロー)
</div>
<div class="list-row-2-row border" style="--column-number: 4;">

- ああああああああ
- b
- c
- d
- e
- f
- g

</div>

<div>
横二段組リスト(列方向フロー) *列数を指定しないため，widthを固定できない．
</div>
<div class="list-row-2-col border" >

- ああああああああ
- b
- c
- d
- e
- f
- g

</div>

<div>カスタム表</div>
<table class="table-orange table-col-4 text-align-right font-small">
  <caption class="font-xlarge">キャプション</caption>
  <tr>
    <th class="font-large">項目1</th>
    <th class="font-large">項目2</th>
    <th class="font-large">項目3</th>
    <th class="font-large">項目4</th>
  </tr>
  <tr>
    <td>1-1</td>
    <td><div>2-1</div><div>2-1</div></td>
    <td>3-1</td>
    <td>4-1</td>
  </tr>
  <tr>
    <td>1-2</td>
    <td>2-2</td>
    <td>3-2</td>
    <td>4-2</td>
  </tr>
</table>

<figure>
  <img src="./assets/demo/pc.jpg" alt="pc">
  <figcaption>普通の画像</figcaption>
</figure>

- a
- b
- c
- d

<div class="layout-col-2" style="--left-width: 40%;">

<figure>
  <img src="./assets/demo/pc.jpg" alt="pc">
  <figcaption>二段組としての画像</figcaption>
</figure>

<div>

- a
- b
- c
- d

$$
 y = ax + b \tag{1}
$$

</div>

</div>

aaaa

<figure class="float-right">
  <img src="./assets/demo/pc.jpg" alt="pc">
  <figcaption>回り込む画像</figcaption>
</figure>

<div>

aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb

$$ y = ax + b $$

ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffgggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg

</div>

<div class="border-blue flex-col" style="padding: 5px;--gap: 5px;">
  <div class="border-red" style="width:20%;">
    aa
  </div>
  <div class="border-yellow" style="width: 50%;">
    bb
  </div>
  <div class="border-green" style="width: 20%;">
    cc
  </div>
</div>

aa

<div class="border-blue flex-row" style="padding: 5px;--gap: 5px;">
  <div class="border-red" style="width:20%;">
    aa
  </div>
  <div class="border-yellow" style="width: 50%;">
    bb
  </div>
  <div class="border-green" style="width: 20%;">
    cc
  </div>
</div>

bb
<div class="border-red text-center" style="height: 4rem;">
aaa
</div>
