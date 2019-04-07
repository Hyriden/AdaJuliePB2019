with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, ada.characters.handling, kit, employe, entreprise, audit, archivage;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, ada.characters.handling, kit, employe, entreprise, audit, archivage;

Procedure main_project is	
	Procedure Menu(car, choix :out character) is
		Begin
			loop
				new_line;
				put_line("Bienvenue dans le menu, veuillez taper sur un des chiffres suivants");
				new_line;
                        Put_Line("0 => Gerer les employes");
 				Put_line("1 => Gerer les kits");
				Put_line("2 => Gerer les entreprises");
				Put_line("3 => Gerer les audits");
				Put_line("4 => Gerer l'archivage");
	 			Put_line("5 => QUITTER..");
				Put(" Choix :");
				get(car);skip_line;
				exit when car='0' or car='1' or car='2' or car='3' or car='4' or car='5';
				put("Erreur saisie");
			end loop;
	end Menu;

	begin
		loop
			Menu(car);
			case car is
                        when '0' =>Put_Line("Bienvenue dans la partie gestion des employes");	
                           loop
                              Put_Line("Veuillez clinquer sur un des caracteres suivants");
                              Put_Line("a => Recrutement d'un employe");
                              Put_Line("b => Supression d'un employe");
                              Put_Line("c => Affichage de tous les employes");
                              Put_Line("d => Depart en congé d'un employes");
                              Put_Line("e => Affichage des employes disponibles");
                              Put_line("f => QUITTER..");
                              Put_line(" Choix :");
                              get(choix); skip_line;
                              exit when Choix='a' or Choix='b' or Choix='c' or Choix='d' or Choix='e' or Choix='f';
                              Put("Erreur saisie");
                           end loop;
                     case Choix is
                        when 'a' => Recrutement;
                        when 'b' => Depart;
                        when 'c' => Affiche_Employe;
                        when 'd' => Depart_Conges; 
                        when 'e' => employe_disponible;
                        when 'f' => exit;
                    end case;
               end case;
            end loop;
end main_project;
