x, y, x_for_user, y_for_user = ARGV

if x_for_user == x && y_for_user == y
	puts "Точка найдена"
elsif x_for_user != x && y_for_user == y
	puts "у координата верна, х нет"
elsif x_for_user == x && y_for_user != y
	puts "x координата верна, y нет"						
else
	puts "Близко, но нет"	
end