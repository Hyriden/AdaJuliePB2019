with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, ada.characters.handling, kit, employe, entreprise, audit, archivage;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, ada.characters.handling, kit, employe, entreprise, audit, archivage;

Procedure main_project is	

--n,3,2,0
option: integer;
choix: character;
EnCours: T_TF_Liste_Audit;
Urgence, Routine: T_TF_File_Demande;
LEtete: T_tete_Liste_Employe; 
LKtete: T_tete_Liste_Kit; 
LEntete: T_tete_Liste_Entreprise; 
dateDuJour: T_Date;


	Procedure Menu(choix:out character) is
		Begin
			loop
				new_line;
				new_line;
				new_line;
		--		put_line("    ╔╦╗┌─┐┌┐┌┬ ┬");
		--		put_line("    ║║║├┤ ││││ │");
		--		put_line("    ╩ ╩└─┘┘└┘└─┘");

				
				Put_Line("Bienvenue dans le menu, veuillez taper sur un des chiffres suivants");
				New_Line;
				Put_Line("0 => Saisie date du jour");
				Put_Line("1 => Gerer les employes");
				Put_Line("2 => Gerer les kits");
				Put_Line("3 => Gerer les entreprises");
				Put_Line("4 => Gerer les audits");
				Put_Line("5 => Gerer l'archivage");
				Put_Line("6 => Lendemain");
				Put_Line("7 => QUITTER..");
				Put(" Choix :");
				Get(Choix);
				Skip_Line;
				exit when Choix='0' or Choix='1' or Choix='2' or Choix='3' or Choix='4' or Choix='5' or Choix='6' or Choix='7';
				Put("Erreur saisie"); new_line;
				end loop;
	end Menu;

		Begin
			loop
				Menu(Choix);
				case Choix is
					when '0' => Saisie_T_Date(dateDuJour);
						put("Nous somme le:"); 
						put(dateDuJour.jour);put("/"); 
						put(dateDuJour.mois);put("/"); 
						put(dateDuJour.annee); new_line;					
					when '1' => Put_Line("Bienvenue dans la partie gestion des employes");
				    	loop
				    		Put_Line("a => Recrutement d'un employe");
				    		Put_Line("b => Supression d'un employe");
				    		Put_Line("c => Affichage de tous les employes");
				    		Put_Line("d => Depart en conge d'un employes");
				    		Put_Line("e => QUITTER..");
				    		Put(" Choix :");
				    		Get(Choix);
				    		Skip_Line;
				    		exit when Choix='a' or Choix='b' or Choix='c' or Choix='d' or Choix='e' ;
				    		Put("Erreur saisie"); new_line;
				   	 	end loop;
						case Choix is
							when 'a' => recrutement(LEtete.tete);
							when 'b' => Depart(LEtete);
							when 'c' => Affiche_Employe(LEtete.tete, dateDuJour);
							when 'd' => Depart_Conges(LEtete.tete, dateDuJour);
							when 'e' => NULL;
							when others => put ("C'EST IMPOSSIBLE -> problème dans procedure MENU");
						end case;

				   when '2' => Put_Line("Bienvenue dans la partie gestion des kits");
				            loop
				               Put_Line("a => Ajouter un kit");
				               Put_Line("b => Supression un kit");
				               Put_Line("c => Affichage de tous les kits");
				               Put_Line("d => QUITTER..");
				               Put(" Choix :");
				               Get(Choix);
				               Skip_Line;
				               exit when Choix='a' or Choix='b' or Choix='c' or Choix='d';
				               Put("Erreur saisie"); new_line;
				            end loop;
				            case Choix is
				               when 'a' => Ajout_Kit(LKtete, dateDuJour);
				               when 'b' => Suppr_Kit (LKtete);
				               when 'c' => Affiche_Kit (LKtete.tete);
				               when 'd' => NULL;
							   when others => put ("C'EST IMPOSSIBLE -> problème dans procedure MENU"); new_line;                                                                                
				            end case;

				         when '3' => Put_Line("Bienvenue dans la partie gestion des entreprises");
				            loop
				               Put_Line("a => Ajouter une entreprise");
				               Put_Line("b => Supression une entreprise");
				               Put_Line("c => Affichage de tous les entreprises");						   
				               Put_Line("d => QUITTER..");
				               Put(" Choix :");
				               Get(Choix);
				               Skip_Line;
				               exit when Choix='a' or Choix='b' or Choix='c' or Choix='d';
				               Put("Erreur saisie"); new_line;
				            end loop;
				            case Choix is
				               when 'a' => Ajout_Entreprise(LEntete);
				               when 'b' => Suppr_Entreprise(LEntete);
							   when 'c' => Affiche_Entreprise (LEntete.tete);
				               when 'd' => NULL; 
							   when others => put ("C'EST IMPOSSIBLE -> problème dans procedure MENU"); new_line;                                                                                
				            end case;


				         when '4' => Put_Line("Bienvenue dans la partie gestion des audits");
				            loop
				               Put_Line("a => Faire une demande d'audits");     
				               Put_Line("b => Afficher la liste des demandes d'Urgences");  
				               Put_Line("c => Afficher la liste des demandes de Routines");
				               Put_Line("d => Afficher les audits en cours");                                    
				               Put_Line("e => QUITTER..");
				               Put("Choix : ");
				               Get(Choix);
				               Skip_Line;
				               exit when Choix='a' or Choix='b' or Choix='c' or Choix='d' or Choix='e';
				               Put("Erreur saisie"); new_line;
				            end loop;
				            case Choix is
				               when 'a' => Insertion_Liste_Demande (Urgence, Routine, dateDuJour, LEntete);
				               when 'b' => Affiche_liste_audit (Urgence.tete);
				               when 'c' => Affiche_liste_audit (Routine.tete);
				               when 'd' => Affiche_audit_en_cours (EnCours.tete);
				               when 'e' => NULL;
							   when others => put ("C'EST IMPOSSIBLE -> problème dans procedure MENU");                                                                                
				            end case;
         
				         when '5' => Put_Line("Bienvenue dans la partie gestion des archives");
				            loop
				               Put_Line("a => Telecharger les archives");
				               Put_Line("b => Afficher audit termines");
				               Put_line("c => QUITTER..");
				               Put("Choix");
				               Get(Choix);
				               Skip_Line;
				               exit when Choix='a' or Choix='b' or Choix='c';
				               Put_Line("Erreur saisie"); new_line;
				            end loop;
				            case Choix is 
				               when 'a' => NULL; --Telecharger_Archive;
				               when 'b' => NULL; 
							   when others => put ("C'EST IMPOSSIBLE -> problème dans procedure MENU");
				            end case;
   				         when '6' => Put_Line("Passage au lendemain");
			            	loop
			            		Put_Line("a => 1 jour");
			            		Put_Line("b => x jours");
			               	  	Put_line("c => QUITTER..");
								Put("Choix :");
			               		Get(Choix);
			               	 	Skip_Line;
			               	 	exit when Choix='a' or Choix='b' or Choix='c';
			               	 	Put_Line("Erreur saisie"); new_line;
			            	end loop;
				            case Choix is 
				               when 'a' => Passage_au_lendemain(EnCours, Urgence, Routine, LEtete, LKtete, LEntete, dateDuJour);
				               when 'b' => put("Saisie nombre de jours a passer :"); get(option); skip_line;
							   		for i in 1..option loop
										Passage_au_lendemain(EnCours, Urgence, Routine, LEtete, LKtete, LEntete, dateDuJour);
									end loop;
				               when 'c' => NULL;  
							   when others => put ("C'EST IMPOSSIBLE -> problème dans procedure MENU"); new_line;
				            end case;
						 when '7' => exit;
						 when others => put ("C'EST IMPOSSIBLE -> problème dans procedure MENU"); new_line;				
				      end case;
				   end loop;            
				
end main_project;