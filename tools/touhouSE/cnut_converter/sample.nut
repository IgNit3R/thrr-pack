function hoge() {
  print("Hello, world!!\n")
}
hoge()
print(vargv.len())
print(vargv[0])
print(this.len())

a = 128
b = 1.28
c = "hoge"
d = "fuga"
print(a, b, c, d)
e = a <- 2
delete a
null
print(null, null, null, null)
::hoge
0 == 1
0 != 1
0 < 1
0 <= 1
0 > 1
0 >= 1
0 <=> 1
a = class {}
b = class extends a {}
print({});
print([]);
0 in [];
0 instanceof 1
hoge() && hoge();
hoge() && hoge() && hoge();
true || true;
-a;
!true;
~a;
0 + 1;
0 - 1;
0 * 1;
0 / 1;
0 % 1;
0 & 1;
0 | 1;
0 ^ 1;
0 << 1;
0 >> 1;
0 >>> 1;
true == true;
if (true) {a = 0;}
if (0 < 1) {a = 0;}
[a, "hoge", 1, 0.5, true];
a = []
print(a.a += 0);
a.a -= 0
a.a /= 0
a.a *= 0
a.a %= 0
++a;
--a;
a++;
a--;
++vargv;
vargv++;
(0 , 1)
a = function() {
  return 1;
}
a = function(a) {
  return 1;
}
a = function(a,b) {
  return 1;
}
yield;
yield 0;
yield a;
local l1 = 0;
local l2 = 0;
yield;
a = function() {
  yield;
};
b = a();
resume a;
foreach(a in [0,1]) print(a)
foreach(i, a in [0,1]) print(a)
foreach(i, a in [0,1]) print(i)
a = clone 0;
typeof 0;
try {
} catch (ex) {
  print(ex);
}
try {
  print(a);
} catch (ex) {
  print(ex);
}
throw 0;
class A {
  a = 0
  </ hoge = "fuga" />
  b = 1
  static c = 2
  </ hige = false />
  static d = 3
};
base;
base.a();
function fuga(c, a = "hoge", b = 128) {print(a);}
local local1 = 128;
local local2 = 256;
local captureFunc1 = function() {
  print(local1, local2);
  local2 = 512;
  local local3 = 1024;
  local captureFunc2 = function() {
    print(local1, local2, local3);
    local2 = 2048;
    local3 = 4096;
  };
  print(local1, local2, local3);
};
return a;

