global.Environment = 70
global.Balance = 50
global.Population = 40
global.Profit = 0
global.Months = 0
global.sinceLastEvent = 0

global.Residential = {
	ApartmanBlock : 1, //1db épület - 3 szint
	Insulation : 0,
	Filtration : 0
}

global.Factory = {
	Factories : [], //factory array
	Filtration : 0,
	Damage : 0
}

global.Public = {
	Healthcare : 0,
	Police : 0,
	Fire : 0,
	Trafic : 1,
	Power : 1
}

global.Ticker = function(){
	global.Environment = 100 - (global.Residential.ApartmanBlock*clamp(10-global.Residential.Filtration,0,10))
	global.Environment = global.Environment-(Damage*clamp(10-global.Factory.Filtration,0,10))
	global.Environment = global.Environment-(global.Public.Power*10)
	global.Environment = global.Environment-(global.Public.Trafic*10)
	
	global.Population = 30+(global.Residential.ApartmanBlock*10)
	
	global.Profit = 0;
	array_foreach(global.Factory.Factories, function(_element, _index){
		global.Profit += _element.profit
	})
	
	global.Balance += global.Profit
}

