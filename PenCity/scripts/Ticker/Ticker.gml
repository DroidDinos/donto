function Ticker(){
	global.Environment = 100
	for(i = 0; ds_grid_width(global.Grid)>i; i++){
		for(j = 0; ds_grid_height(global.Grid)>j; j++){
			global.Environment -= ds_grid_get(global.Grid,i,j).damage
		}
	}
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