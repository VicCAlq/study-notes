local ho = function(value)
	return function(another)
		return value + another
	end
end

print(ho(1)(2))
