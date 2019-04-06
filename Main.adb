with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, ada.characters.handling, kit, employe, entreprise;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, ada.characters.handling, kit, employe, entreprise;

Procedure main_project is	
	Procedure Menu(option:out character) is
		Begin
			loop
				new_line;
				put_line("    ╔╦╗┌─┐┌┐┌┬ ┬");
				put_line("    ║║║├┤ ││││ │");
				put_line("    ╩ ╩└─┘┘└┘└─┘");
				new_line;
				Put_line("0 => Passer au lendemain");
				Put_line("1 => Enregistrer un employé");
				Put_line("2 => Visualiser les employés");
				Put_line("3 => Gerer congé employé");
				Put_line("4 => Départ employé");
				Put_line("5 => Ajouter un kit");
				Put_line("6 => Visualiser les kits");
				Put_line("7 => Supprimer un kit");
				Put_line("8 => Ajouter une Entreprise");
	 			Put_line("9 => QUITTER..");
				Put(" Choix :");
				get(option);skip_line;
				exit when option='0' or option='1' or option='2' or option='3' or option='4' or option='5' or option='6'or option='7' or option='8' or option='9';
				put("Erreur saisie");
			end loop;
	end Menu;

	begin
		loop
			Menu(option);
			case option is
				when '0' =>init(Tableau_Cuisinier,Planning);			

				when '1' =>recrutement(Tableau_Cuisinier);

				when '2' =>affichage_club(Tableau_cuisinier);
			
				when '3' =>saisie_prestation(Planning,Tableau_Cuisinier);

				when '4' =>affichage_planning(Planning);

				when '5' =>depart(Tableau_Cuisinier,Planning);			
			
				when '6' =>passage_au_lendemain(date_du_jour,Tableau_cuisinier,Planning);
			
				when '7' =>annulation (Planning);

				when '8' =>
	end menu;
end main_project;