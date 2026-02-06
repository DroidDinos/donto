function Consequence(_what, _much, _meddig){
	return{
		what : _what, //string h mit
		much : _much,  // mérték
		meddig : _meddig
	}
}

function Choice(_answer, _cost, _building, _consequence){
	return {
		answer : _answer,
		cost : _cost,
		requirement : _building,
		consequence : _consequence //array of az
	}
}


function Event(_type, _title, _description, _choices){
	return {
		type : _type,
		title : _title,
		description : _description,
		choices : _choices, //array
	}
} 

function whatChoices(_event){
	var correct = []
	for(i = 0; array_length(_event.choices) > i; i++){
		
	}
	
}