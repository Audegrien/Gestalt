/// @param text_id
function scrGameText(_text_id)
{
	    // Inventory “virtual IDs”
    if (string_copy(_text_id, 1, 4) == "INV|")
    {
        scrInventoryText(_text_id);
        return;
    }
	
	switch(_text_id){
	//------------------------How to Create Dialogue------------------------\\

	//-----Not Branching, (No Options for reply)-----\\
	//case "Text ID":
		//scrText("Example Text 1");
		//scrText("Example Text 2");
		//break;


	//-----Branching, (Options to reply)-----\\
	//case "Text ID":
		//scrText("Example Text 1");
		//scrText("Example Text 2");
			//scrOption("Text for Option 1", "Option 1 ID");
			//scrOption("Text for Option 2", "Option 2 ID");
			//scrOption("Text for Option 3", "Option 3 ID");
		//break;
		//case "Option 1 ID":
			//scrText("Example Text 1");
			//scrText("Example Text 2");
			//break;
		//case "Option 3 ID":
			//scrText("Example Text 1");
			//scrText("Example Text 2");
			//break;
		//case "Option 3 ID":
			//scrText("Example Text 1");
			//scrText("Example Text 2");
			//break;



	//------------------------All Dialogue Within the Game------------------------\\

			//------------------------Home------------------------\\
			
			
				//------------------------Bedroom------------------------\\
					case "Home Bedroom Bed":
						scrText("It's just my bed..");
						scrText("I didnt get much sleep.");
						scrText("Should i rest?");
							scrOption("Yes", "Home Bedroom Bed - Yes");
							scrOption("No", "Home Bedroom Bed - No");
						break;	
						case "Home Bedroom Bed - Yes":
							scrText("It is late..");
							global.mental_state -= 1;
							show_debug_message(global.mental_state);
							break;
						case "Home Bedroom Bed - No":
							scrText("I should find my wife first.");
							break;
		
					case "home Bedroom Window":
						scrText("It's raining outside today.");
						scrText("I never liked the rain.");						
						break;
					
					case "Home Bedroom Shelf":
						scrText("My shelf, containing some figures.");
						scrText("Figures so expensive, that even a Devil May Cry...");
						break;
					
					case "Home Bedroom Desk":
						scrText("My desk. It looks like i left these documents out.");
						scrText("I'll put them away later.");
						break;
					
					case "Home Bedroom Dresser":
						scrText("It's my wardrobe.");
						scrText("Should i get changed?");
							scrOption("Yes", "Home Bedroom Dresser - Yes");
							scrOption("No", "Home Bedroom Dresser - No");
						break;	
						case "Home Bedroom Dresser - Yes":
							scrText("Huh.. My clothes are gone.");
							break;
						case "Home Bedroom Dresser - No":
							scrText("Maybe later.");
							break;
						
					case "Home Bedroom Lightswitch":
						scrText("Turn the light off?");
							scrOption("Yes", "Home Bedroom Lightswitch - Yes");
							scrOption("No", "Home Bedroom Lightswitch - No");
						break;	
						case "Home Bedroom Lightswitch - Yes":
							scrText("It doesn't work.");
							break;
						case "Home Bedroom Lightswitch - No":
							scrText("...");
							break;		
				//------------------------Main Room------------------------\\
					case "Sons Door":
						scrText("My sons room..");
						scrText("He's probably sleeping. I should let him rest.");
						break;
		

		}

	}