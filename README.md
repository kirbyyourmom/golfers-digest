# Ruby tips for code golf!

## Index
- [What is Ruby code golfing?](#what-is-ruby-code-golfing)
- [Array qssignment](#array-assignment)
- [uniq(ue)](#unique)
- [Joining arrays](#joining-arrays)
- [Include](#include)
- [`tr` instead of `gsub`](#tr-instead-of-gsub)
- [`chop` instead of `chomp`](#chop-instead-of-chomp)
- [dash rocket / stabby lambda](#dash-rocket--stabby-lambda)
- [Curb your `do` `end`](#curb-your-do-end)
- [Ternary if](#ternary-if)
- [Scientific notation](#scientific-notation)
- [Unary operators](#unary-operators)
- [Range to Array conversion](#range-to-array-conversion)
- [Shorter way of using `compact`](#shorter-way-of-using-compact)
- [Replacing `true` and `false`](#replacing-true-and-false)
- [Checking if an element is inside a range](#checking-if-an-element-is-inside-a-range)
- [`digits`](#digits)
- [Using `clamp`](#using-clamp)
- [Set precision for `ceil` and `floor`](#set-precision-for-ceil-and-floor)


## What is Ruby code golfing?
Code golfing is a "sport" of writing the smallest/shortest amount of code to do a particular thing/task. An example of which can be [making a morse encoder](https://code.golf/morse-encoder#ruby) in the shortest amount of code possible. And ruby code golfing, is basically code golfing but, in ruby!

⚠ **WARNING: Do this only as a challenge. Do not practice any of the following in commercial projects, or just projects themselves. Code golfing makes code hard to read, understand, and debug (as you'll see in a bit) which is *complete* opposite of professional code.**


### Array assignment

If you want to assign a single array literal to a variable, you can use a splat operator on the LHS of the assignment.

```rb
a=[0]  # before
*a=0   # after
```

If you have multiple values, however, you don't need the splat operator at all!

```rb
a=[0,1,1,2]  # before
a=0,1,1,2    # after
```

[back to top ↑](#ruby-tips-for-code-golf)

### uniq(ue)

If you want to find the unique values of an iterable, you'd use the `uniq` method. There's a shorter way though! ![](https://github.com/radius2703/golfers-digest/blob/master/assets/picardia-x32.png?raw=true)

```rb
a=0,1,1,2,2,3,3  # uses the trick mentioned above

a.uniq  # before
a|[]    # 2 chars shorter
a&a     # 3 chars shorter in total!
```

If you need to assign an empty array as well, you can use this which will save even more chars:

```rb
a.uniq;b=[]  # before
a|b=[]       # after, an astounding 5 chars difference!
```

[back to top ↑](#ruby-tips-for-code-golf)

### Single character string literal shorthand

If you use a single character string literal somewhere in an expression, you'd probably use `'a'` or `"a"`. But there's a shorthand 

[back to top ↑](#ruby-tips-for-code-golf)

### Joining arrays

Usually, `.join(' ')` does the job, but for code golf, you can use these:

```rb
a=1,2,3,4
a.join  # before
a*' '   # after
```

If you'd like to use a single char delimiter however, you can use the single character shorthand which is `?<character>` which is shown above.

```rb
a.join(',')  # before
a*?,         # after, an astounding 7 char difference!
```

[back to top ↑](#ruby-tips-for-code-golf)

### Include
If you want to check whether a string contains a substring, you can use `[]` instead of `include?`

```rb
a="foobar"

a.include?"foo"  # before
a["foo"]         # after, an astounding 7 chars difference!
```

If the string *includes* the substring, then it returns the substring instead of a boolean for the first one.

```rb
a["foo"]  #=> "foo"
```

As a bonus, you can even use regular expression! ![](https://github.com/radius2703/golfers-digest/blob/master/assets/picardia-x32.png?raw=true)

```rb
a="fooooooo"
p a[/fo+/]  #=> "fooooooo"
```

[back to top ↑](#ruby-tips-for-code-golf)

### `tr` instead of `gsub`

If you want character-wise substitution, use `tr` instead of `gsub`

```rb
"101011".tr('10','AB')
# or
"101011".tr'10','AB'
```

[back to top ↑](#ruby-tips-for-code-golf)

### `chop` instead of `chomp`

If you need to remove the trailing new-line character, you can use `chop` instead of `chomp`

```rb
gets.chomp  # before
gets.chop   # after
```

⚠ **WARNING: `chop` chops the last character off the string. If there's no newline character at the end, it will eat up the last character.**

```rb
a="foobar\n"
a.chop  #=> "foobar"

a="foobar"
a.chop  #=> "fooba"
```

[back to top ↑](#ruby-tips-for-code-golf)

### dash rocket / stabby lambda

Use the dash rocket/stabby lambda operator (new in 1.9) instead of `def` .. `end`.

```rb
def max*n
n.max
end              # before

max=->*n{n.max}  # after, saves usually around 5 characters
```

⚠ **WARNING: function calls use `[]` or `.()` instead of `()`**

```rb
max(1,2)  # using def .. end
max[1,2]  # using the dash rocket operator
max.(1,2) # " "
```

This means you cannot exclude the brackets.
So you'll have to sacrifice 1 char in certain cases.

[back to top ↑](#ruby-tips-for-code-golf)

### Curb your `do` `end`

Instead of using `do` and `end` for certain methods, you can use `{`..`}` block. This saves 3-5 characters. You'll see why.

```rb
a=0,1,1,2
a.each do|a|p a end  # before
a.each{|a|p a}       # after
```

But, here's the problem. The precedence of `{`..`}` is high. Because of that, you'll need brackets around some.

```rb
(?a..?m).zip (1..5).cycle do|a|puts a*?,end  # before
(?a..?m).zip (1..5).cycle{|a|puts a*?,}      # wrong, since it applies it to cycle not zip
(?a..?m).zip((1..5).cycle){|a|puts a*?,}     # correct, applies it to zip not cycle
```

[back to top ↑](#ruby-tips-for-code-golf)

### Ternary if

Instead of `if`..`else`..`end` you can use the ternary if syntax. `?:`

```rb
k=?1
if k==?1
p 1
else
p 0
end          # before

p k==?1?1:0  # after, saves 14 chars! (in this case)
```

[back to top ↑](#ruby-tips-for-code-golf)

### Scientific notation

Remember scientific notation from school? Ruby has a way to use that.

```rb
a=10000  # before
a=1e4
```

Be careful though, this returns a floating point number, so thing *can* get inaccurate as the number becomes larger.

[back to top ↑](#ruby-tips-for-code-golf)

### Unary operators

You must have heard about BODMAS or PEMDAS depending upon where you live. In programming however, it's UBODMAS or UPEDMAS. The 'U' stands for Unary. Unary operators have higher precedence than arithemetic (not including exponentiation)
`~-a` is equivalent to `a-1` and `-~a` is equivalent to `a+1`
```rb
2*(1+2)  # correct, but *long*
2*1+2    # wrong, according to BODMAS multiplication has higher precedence than addition
2*-~2    # correct, 2 char shorter
```

[back to top ↑](#ruby-tips-for-code-golf)

### Range to Array conversion

There's a shorter way to convert a range to an array by using the splat operator. Here's how:

```rb
(1..42).to_a  # before
[*(1..42)]    # after, but can be shortened even more
[*1..43]      # after, 4 char difference.
```

[back to top ↑](#ruby-tips-for-code-golf)

### Shorter way of using `compact`

The `compact` method is used to remove falsy elements
from an array. There's a shorter way to do so, though. \<insert picardia>

```rb
a=0,1,nil,2,nil,3,4,nil,nil
a.compact  # before
a-[nil]    # after, but can be shortened
a-[p]      # shorter by 4 chars total
```

[back to top ↑](#ruby-tips-for-code-golf)

### Replacing `true` and `false`

`true` and `false` weren't too short for you? Well here's a trick to make them shorter ![](https://github.com/radius2703/golfers-digest/blob/master/assets/picardia-x32.png?raw=true)

```rb
true  # before
!p    # after

false # before
!0    # after
```

[back to top ↑](#ruby-tips-for-code-golf)

If you just want a falsy value, you can use `p` which returns `nil` instead of `!0`.

### Checking if an element is inside a range

If you need to check if a particular element is inside a range, then you can use the following instead:

```rb
(1..42).include?42  # before
(1..42)===42        # after, saved 6 characters
```

[back to top ↑](#ruby-tips-for-code-golf)

### `digits`

To get the digits of a number you can do the following:

```rb
a=42
a.to_s.chars.map(&:to_i)  # before
a.digits                  # after
```

[back to top ↑](#ruby-tips-for-code-golf)

### Using `clamp`

Wanted to keep a number between the range of 2 numbers? The `clamp` method can come handy then. It does exactly what it says. It clamps it to a minimum if the number is lower than it, or to the maximum if higher.

```rb
min,max=0,42
a,b=46,-3
a.clamp(min,max)  #=> 42
b.clamp(min,max)  #=> 0
```

[back to top ↑](#ruby-tips-for-code-golf)

### Set precision for `ceil` and `floor`

If you want to floor or ceil a floating number, but not truncate it completely to an integer, and instead have a set precision, you can pass a precision argument in the method.

```rb
pi=3.1416
pi.floor 1  #=> 3.1
pi.ceil 1   #=> 3.2
```

[back to top ↑](#ruby-tips-for-code-golf)
