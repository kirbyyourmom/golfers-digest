a=[0]  # before
*a=0   # after

a=[0,1,1,2]  # before
a=0,1,1,2    # after


a=0,1,1,2,2,3,3  # uses the trick mentioned above

a.uniq  # before
a|[]    # 2 chars shorter
a&a     # 3 chars shorter in total!


a.uniq;b=[]  # before
a|b=[]       # after, an astounding 5 chars difference!


a=1,2,3,4
a.join  # before
a*' '   # after

a.join(',')  # before
a*?,         # after, an astounding 7 char difference!


a="foobar"

a.include?"foo"  # before
a["foo"]         # after, an astounding 7 chars difference!

a["foo"]  #=> "foo"

a="fooooooo"
p a[/fo+/]  #=> "fooooooo"


"101011".tr('10','AB')
# or
"101011".tr'10','AB'


gets.chomp  # before
gets.chop   # after

a="foobar\n"
a.chop  #=> "foobar"

a="foobar"
a.chop  #=> "fooba"


def max*n
    n.max
end              # before

max=->*n{n.max}  # after, saves usually around 5 characters

max(1,2)  # using def .. end
max[1,2]  # using the dash rocket operator
max.(1,2) # " "


a=0,1,1,2
a.each do|a|p a end  # before
a.each{|a|p a}       # after


(?a..?m).zip (1..5).cycle do|a|puts a*?,end  # before
(?a..?m).zip (1..5).cycle{|a|puts a*?,}      # wrong, since it applies it to cycle not zip
(?a..?m).zip((1..5).cycle){|a|puts a*?,}     # correct, applies it to zip not cycle


k=?1
if k==?1
p 1
else
p 0
end          # before


p k==?1?1:0  # after, saves 14 chars! (in this case)


a=10000  # before
a=1e4


2*(1+2)  # correct, but *long*
2*1+2    # wrong, according to BODMAS multiplication has higher precedence than addition
2*-~2    # correct, 2 char shorter


(1..42).to_a  # before
[*(1..42)]    # after, but can be shortened even more
[*1..43]      # after, 4 char difference.


a=0,1,nil,2,nil,3,4,nil,nil
a.compact  # before
a-[nil]    # after, but can be shortened
a-[p]      # shorter by 4 chars total


true  # before
!p    # after

false # before
!0    # after


(1..42).include?42  # before
(1..42)===42        # after, saved 6 characters


a=42
a.to_s.chars.map(&:to_i)  # before
a.digits                  # after


min,max=0,42
a,b=46,-3
a.clamp(min,max)  #=> 42
b.clamp(min,max)  #=> 0


pi=3.1416
pi.floor 1  #=> 3.1
pi.ceil 1   #=> 3.2
