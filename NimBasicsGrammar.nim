# 文法をまとめたものなので実行してもエラーが出るので注意
# <>は変更可能なもの

# 実行方法:nim c -r filename.nim

# ハローワールド
echo "hello world"
#======================================================================================================
# 変数宣言
# キャメルケースとスネークケースをサポート
# キャメルケース：NimMain（大文字に注目）
# スネークケース：nim_main（アンダーバーに注目）
# Nimのライブラリの関数等はキャメルケースで書かれているのでキャメルケースの方がおすすめ
#-------------------------------------------------------------------------------------------------------
# var name : <型>
var name : int

# 変数宣言+代入
# var <name> : <型> = <値>
var name : int = 10

# 型推論使用時
# var <name> = <値>
var name = 10

# 連続した変数の宣言
#[
  var
    <name> = <値>
    <name> = <値>
    ]#
# インデントはTabではなくスペース2文字
var
  name1 = 10
  name2 = "aidcnsd"

#--------------------------------------------------------------------------------------------------------
# 宣言のキーワードは三種類ある
#var:変数としていつでも変更することができる（カウンタとか？）
#let:最初は空でも問題ないが、一度でも値をセットすると変更ができない（計算結果等）
#const:最初から値が入っていなければならず、変更もできない（一番使う）
#---------------------------------------------------------------------------------------------------------
# 整数
# 数値の可読化向上に_をサポート
# a = 100_000
let a = 100_000
let a = 0x1abc_abcd

# 計算用の演算子(+,-,*,/,div,mod)をサポート
# div:小数点切り捨て除算 mod:除算による余剰
#----------------------------------------------------------------------------------------------------------
# 浮動小数点
# (2.73,-3.14,5.0,4e7)等
# 4e7 = 4 * 10 ^7
echo 4e7

#----------------------------------------------------------------------------------------------------------
# 文字
# char型はASCⅡ文字を一文字を表すのに使用する
# 単一引用符'を使用し'A'のように書く、使用できるのは文字、記号、1桁の数字（1バイト）
let
  h = 'A'
  g = '1'
  i = '+'

# 文字列は他の言語と同様に二重引用符"でくくる
let
  a = "ABC"
  b = "" # 空文字
  c = " I study nim"

# 特殊文字も、マニュアルに詳しいことは書いてあるが、基本は多言語と同じ
echo "Nim\nstudy\t."
# rを二重引用符に前に入れることで特殊文字を無視することができる
echo r"Nim\\is\t\n"

#----------------------------------------------------------------------------------------------
# 文字列
# Nimの文字列は可変であるにで、内容を変えることができる
# add関数を使うと、既存の文字列に、別の文字列や単一の文字の追加を行える
var # 文字列をいじるので
  a = "Nim"
  b = "study"
echo a.add(" study")
echo a.add(b)
# 元の文字列をそのままにして、結果のみ変更する場合&演算子を利用する
let
  a = "Nim"
  b = "Study"

echo "結果は",a & b

#---------------------------------------------------------------------------------------------------------
# ブーリアン
# ブーリアン型は他の言語同様、TrueかFalseを返す
# 関係演算子の結果（==,!=,>,<=,>=,<,）
let
  a = 12
  b = 1
echo a == b
echo a != b

# 文字や文字列の比較も可能
# （大文字は小文字の前に来る、同一以外は文字列の長さは関係ない、短い文字列は長い文字列より小さくなる）
# 文字列比較は文字ごとに行う
let
  a = "axyb"
  b = "ba"
echo a < b

# ブーリアンでAND、OR、XOR、NOTを利用して、ブーリアンで返させることもできる
let
  a = true
  b = false
echo true and false

#==========================================================================================================-

# 制御構文

# if文
# Pythonと似ており
#[
if <条件> :
  <処理>
と記述する]#
let
  a = 1
  b = 2
if a < b:
  echo "Nim"

#------------------------------------------------------------------------------------------
# else
# if文の条件結果がFalseだった場合に実行される
#[
else:
  <処理>
これもPython同様]#
let
  a = 1
  b = 3
if a > b:
  echo "Python"
else:
  echo "Nim"

#---------------------------------------------------------------------------------------------
# elif
# else ifの略
#[
elif <条件>:
  <処理>
Pythonと似ている]#
let
  a = 1
  b = 3
if a > b:
  echo "Python"
elif a < b:
  echo "Nim"

#------------------------------------------------------------------------------------------------------
# case
# switch文みたいなかんじ
#[
case <固定値>:
  of <条件>:
    <処理>
  of <条件>:
    <処理>
と独特な記述を行うが、switchと余り変わらない]#
# case文では全てのケースの条件を用意しなければならない
# 用意しない方法としてelse: discardと書くことができる（基本は付ける）
#[
  else:
    <処理>
とも記述できる
]#
let i = 7

case i
    of 0:
      echo "C"
    of 1,2,3,4,5,6,8:
      echo "Rust"
    of 7:
      echo "Nim"
    else: discard
      # echo "処理を書く際はdiscardは外す"

#--------------------------------------------------------------
# ループ
# for文
# 構文はPythonに似ており
#[
for <ループ変数> in <ループ可能> :
  <ループ内処理>
]#
# ただイテレータの書き方が特殊で
# <start>..<end>と記述する、これはrange(start,end)に当たる
# <end>を含めたくない場合は、..<を使用する
# 他にもcountupでカウンタを数えることができる
# countup(<開始値>, <終了値>, <ステップサイズ>)
# ステップサイズでステップサイズずつ飛ばし飛ばしにカウントできる
# countdownはカウンタをデクリメントしてゆく
var i:int
for i in 1..7:
  echo i

for i in countup(1, 8, 2):
  echo i

for i in countdown(8, 1, 2):
  echo i

#-------------------------------------------------------------------------------------------------
# for-each文のように文字列を変数にいれて、各文字を処理することができる(2進数でも処理できるか気になる)
let word = "abcd"

for i in word:
  echo i

#-------------------------------------------------------------------------------------------------
# 0から始まる、何回繰り返したかのループカウンタを用意する構文もある
#[
for <カウンタ変数（0から）>, <ループ変数> in <イテレータ>:
  <処理>
]#
let word = "abcd"

for i, letter in word:
  echo i, letter

#-----------------------------------------------------------------------------------------------------
# whileループ
# これもPythonの構文とほぼ同じ
#[
while <条件>:
  <処理>
]#
# インクリメントをする際は、inc <変数>で、 <変数> += <変数>(<変数> = <変数> + 1)の変わりをすることができる
var a = 1

while  a*a < 10:
  echo a
  inc a
echo a

#------------------------------------------------------------------------------------------------------
# BreakとContinue
# Pyhtonと同じ
#======================================================================================================
# コンテナ
# 要素を管理できるデータ型の一つ
#---------------------------------------------------------------------------
# 配列
# 全ての要素は同じ型である必要がある
# 要素の個数はコンパイル時にわかっていなければならない
# 宣言の仕方は<配列名> : arry[<要素数>, <型>] = [<要素>,...,<要素>]
# 空配列の宣言の仕方は、<配列名> : arry[<要素数>, <型>]
# 要素の個数は定数（const）で宣言しないといけない
const
  a = 6
var
  b: arry[5, int] = [1,2,3,4,5]
  c: arry[7, string]
  d: arry[a, int]

#-----------------------------------------------------------------------------
# シーケンス
# 配列と違い、長さがコンパイル時にわかってなくてよい
# 空のシーケンサを定義する必要がある。
# 宣言はseq[<型>]
# 要素の定義は、@[<要素>]
# 要素を定義しているなら、推測できるので型宣言は必要ない

var
  a: seq[int] = @[1,2,3]
  b = @["nim","Rust","Go"]

# newSeqプロシージャでもシーケンスの初期化ができる
var
  c = newSeq[int]() # ()忘れに注意

# add関数を利用して(同じ型の)要素を追加することができる
# その際にはシーケンスをvarで宣言している必要がある
# シーケンスに（同じ型の）シーケンスを追加することもできる
var
  d = @['X','Y']
  e = @['A','B']
d.add('Z')
d.add(e)
# 長さを取得するには、len関数を使用
echo d.len

#-------------------------------------------------------------------------
# インデックスとスライス
# 基本的に他の言語と同じだけど、末尾からもa[^<インデックス>]
# 指定できる
# スライスは[<start> .. <stop>]

#-----------------------------------------------------------------------------------
# タプル
# 異種データを含む配列で、構造体みたいな奴
# 文法はシンプルに括弧でかく、(<要素>,<要素>,<要素>)
var a = ("NIm", 1, 'c')
#各フィールドを区別するための、名前を書くこともできる
# (<名前>: <要素>,<名前>: <要素>)
var a = (Name : "Nim", Age : 12, Friend : 'C')
# インデックスを使用する方法とフィールドの名前を利用したa.Name = "Nim1" の方法がある

#====================================================================================
# プロシージャ
# 他のプログラム言語でいう関数
# echo,add,incなどはもともと組み込まれていた関数
# Nimにおいてfuncは数学用の関数として予約されている
#-------------------------------------------------------------------------------------
# プロシージャの宣言
# proc <プロシージャ名>(<引数1>: <型1>, <引数2>: <型2>, ...): <戻り値の型>
# プロシージャの記述
#[
proc <プロシージャ名>(<引数1>: <型1>, <引数2>: <型2>, ...): <戻り値の型> =
  <処理>
]#
proc echoLanguage(language : string) = # 戻り値がないので型を定義する必要がない
  case language
  of "Nim", "nim", "NIM":
    echo language, "は最高の言語です！"
  else:
    echo language, "は二番目に良い言語でしょう。"

#--------------------------------------------------------------------------------------
# 基本の書き方だと、引数は変更できない
# 変更するには、引数をvarキーワードで定義する必要がある
proc chanegeArgument(argument: var int) = # varに変更されている
  argument += 5

var ourVariable = 10
chanegeArgument(ourVariable)
echo ourVariable
chanegeArgument(ourVariable)
echo ourVariable

#---------------------------------------------------------------------------------------
# プロシージャの外で宣言された変数（定数）名を使用することができる
var x = 10

proc echoX() =
  echo x
  inc x

echoX()

#---------------------------------------------------------------------------------------
# プロシージャの呼び出し
# <プロシージャ名>(<引数1>, <引数2>, ...)
let
  a = 1
  b = 2
  c : int

c = findMax(a,b)
echo c

#----------------------------------------------------------------------------------------
# Nim言語はUniform Function Call構文(統一関数呼び出し構文)をサポートしている

# <引数>.<プロシージャ名>(<引数>,...)
# 例はadd関数で使用したやつ
a.add("A")

# <プロシージャ名> <引数1>,<引数名2>,...
# 例はecho
echo a

# UFC構文で、複数のプロシージャを読みやすく繋げることができる
proc plus(x, y: int): int =
  return x + y

proc multi(x, y: int): int =
  return x * y

let
  a = 2
  b = 3
  c = 4

echo a.plus(b) == plus(a, b)
echo c.multi(a) == multi(c, a)

echo a.plus(b).multi(c)
echo c.multi(b).plus(a)

#====================================================================================
# 戻り値
# Nimのプロシージャで、返り値の型が定義されている場合は
# 暗黙的にresult変数が定義されている（return文で返す必要はない）
# result変数は、初期値（int:0,stirng:"",seq[int]:@[]）で初期化されている
proc findBiggest(a: seq[int]): int =
  for number in a:
    if number > result:
      result = number # ここでresult変数が返される

let d = @[3,-5,11,33]
echo findBiggest(d)

#====================================================================================
# 前方宣言
# いわゆるプロトタイプ宣言
# proc <プロシージャ名>(<変数名>: <>): <返り値の型>
proc plus(x, y: int): int

echo 5.plus(10)

proc plus(x, y: int): int =
  return x + y

#====================================================================================
# モジュール
# デフォルトの機能を拡張する方法(いわゆるライブラリ)
# よく使われているライブラリは
#[
strutils :文字列を扱う時の追加機能 
sequtils :シーケンス用の追加機能
math :数学の関数（対数、平方根、…）、三角法（sin,cos,...）
times :測定した時間を扱う
]#
# 標準ライブラリ検索サイト：https://nim-lang.org/docs/lib.html
# nimble（公式のパッケージマネージャー）の検索サイト：https://nimble.directory/

#-------------------------------------------------------------------------------------
# モジュールのインポート
# import <moduleName>        (<>はいらない)

import strutils

let
  a = "My string with whitespace."
  b = '!'

echo a.split()
echo a.toUpperAscii()
echo b.repeat(5)

# mathモジュールにもなかなかおもしろいものがある（演算子が増えたりとか）

#--------------------------------------------------------------------------------------
# 自作のモジュールの使い方
# その際に、インポートする関数の宣言に少し変更を加える
# 以下をfirstdile.nimとして保存
proc plus*(a, b: int): int = # このアスタリスクがあることでインポートできる
  return a + b

# second.nimファイルを作成し、以下を記載
import firstFile

echo plus(5, 10)

#======================================================================================
#ユーザー入力のやり方
# ファイルの読み込みや標準入力の読み込み
#--------------------------------------------------------------------------------------
# ファイルの読み込み
# readFileプロシージャを使用する
# readFile("<ファイルのパス>")
let contents = readFile("peple.txt")
echo contents
# strutilsのstripプロシージャは空白文字除いた文字列を抽出できる

#--------------------------------------------------------------------------------------
# ユーザー入力の読み込み
# readLineプロシージャにstdinを渡すことで、やることができる。
let name = readLine(stdin) # nameは文字列とみなされる

echo "Hello",name

#--------------------------------------------------------------------------------------
# 数字の扱い
# ユーザー入力で入力されるデータは、全て文字列として処理される
# よって、数値を利用するためには文字列を数値の型に変換する必要がある
# strutilsモジュールのparseInt(int型)かparseFloat(float型)を使用して変換を行う
import strutils

let a = readLine(stdin).parseInt()

echo a
#=======================================================================================
# ~完~
# 次は、NimTutorial1