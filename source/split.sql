create function split(x varchar(255), delim varchar(12), pos int)
returns varchar(255)
return replace(substring(substring_index(x, delim, pos),
		length(substring_index(x, delim, pos-1))+1),
		delim, 
		'');