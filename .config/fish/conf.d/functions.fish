function get-font-family-name
	fc-query -f '%{family[0]}\n' $argv
end
