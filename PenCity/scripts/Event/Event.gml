function Choice(_answer, _cost, _building, _consequence){
	return {
		answer : _answer,
		cost : _cost,
		requirement : _building,
		consequence : _consequence
	}
}


function Event(_type, _title, _description, _choice1,_choice2,_choice3){
	return {
		type : _type,
		title : _title,
		description : _description,
		choice1 : _choice1,
		choice2 : _choice2,
		choice3 : _choice3
	}
}