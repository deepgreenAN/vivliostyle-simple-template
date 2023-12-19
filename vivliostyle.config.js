// @ts-check
const vivliostyleConfig = {
  title: 'テンプレートドキュメント',
  author: 'Vivliostyle Rust 太郎',
  language: 'ja',
  // readingProgression: 'rtl',
  size: 'A4',
  theme: '@vivliostyle/theme-techbook',
  // image: 'ghcr.io/vivliostyle/cli:8.6.0',
  entry: [
    {
      path: 'docs/index.md',
      title: 'はじめに',
    },
  ],
  output: [ 
    'テンプレートドキュメント.pdf', 
  ],
  workspaceDir: '.vivliostyle', // 中間生成物
  // toc: true,
  // cover: './cover.png',
};

module.exports = vivliostyleConfig;
