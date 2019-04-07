with Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io, Ada.Characters.Handling, Kit, Employe, Entreprise, Audit, Archivage;
use  Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io, Ada.Characters.Handling, Kit, Employe, Entreprise, Audit, Archivage;

procedure Main_Project is
   procedure Menu (Choix :    out Character) is
   begin
      loop
         New_Line;
         Put_Line("Bienvenue dans le menu, veuillez taper sur un des chiffres suivants");
         New_Line;
         Put_Line("0 => Gerer les employes");
         Put_Line("1 => Gerer les kits");
         Put_Line("2 => Gerer les entreprises");
         Put_Line("3 => Gerer les audits");
         Put_Line("4 => Gerer l'archivage");
         Put_Line("5 => QUITTER..");
         Put(" Choix :");
         Get(Choix);
         Skip_Line;
         exit when Choix='0' or Choix='1' or Choix='2' or Choix='3' or Choix='4' or Choix='5';
         Put("Erreur saisie");
      end loop;
   end Menu;

begin
   loop
      Menu(Choix);
      case Choix is
         when '0' => Put_Line("Bienvenue dans la partie gestion des employes");
            loop
               Put_Line("Veuillez cliquer sur un des caracteres suivants");
               Put_Line("a => Recrutement d'un employe");
               Put_Line("b => Supression d'un employe");
               Put_Line("c => Affichage de tous les employes");
               Put_Line("d => Depart en congé d'un employes");
               Put_Line("e => Affichage des employes disponibles");
               Put_Line("f => QUITTER..");
               Put_Line(" Choix :");
               Get(Choix);
               Skip_Line;
               exit when Choix='a' or Choix='b' or Choix='c' or Choix='d' or Choix='e' or Choix='f';
               Put("Erreur saisie");
            end loop;
            case Choix is
               when 'a' => Recrutement;
               when 'b' => Depart;
               when 'c' => Affiche_Employe;
               when 'd' => Depart_Conges;
               when 'e' => Employe_Disponible;
               when 'f' => exit;
            end case;

         when '1' => Put_Line("Bienvenue dans la partie gestion des kits");
            loop
               Put_line("Veuillez cliquer sur un des caracteres suivants");
               Put_Line("a => Ajouter un kit");
               Put_Line("b => Supression un kit");
               Put_Line("c => Affichage de tous les kits");
               Put_Line("d => Affichage des kits disponibles");
               Put_Line("e => QUITTER..");
               Put_Line(" Choix :");
               Get(Choix);
               Skip_Line;
               exit when Choix='a' or Choix='b' or Choix='c' or Choix='d' or Choix='e';
               Put("Erreur saisie");
            end loop;
            case Choix is
               when 'a' => Ajout_Kit;
               when 'b' => Delete_Kit;
               when 'c' => Affiche_Kit;
               when 'd' => kit_disponible;
               when 'e' => exit;                                                                                     
            end case;

         when '2' => Put_Line("Bienvenue dans la partie gestion des entreprises");
            loop
               Put_line("Veuillez cliquer sur un des caracteres suivants");
               Put_Line("a => Ajouter une entreprise");
               Put_Line("b => Supression une entreprise");
               Put_Line("c => QUITTER..");
               Put_Line(" Choix :");
               Get(Choix);
               Skip_Line;
               exit when Choix='a' or Choix='b' or Choix='c';
               Put("Erreur saisie");
            end loop;
            case Choix is
               when 'a' => Ajout_Entreprise;
               when 'b' => Suppr_Entreprise;
               when 'c' => exit;                                                                                     
            end case;


         when '3' => Put_Line("Bienvenue dans la partie gestion des audits");
            loop
               Put_line("Veuillez cliquer sur un des caracteres suivants"); 
               Put_Line("a => Faire une demande d'audits");     
               Put_Line("b => Afficher la liste des audits");  
               Put_Line("c => Afficher les audits en cours");                  
               Put_Line("d => QUITTER..");
               Put_Line("Choix"); 
               Get(Choix);
               Skip_Line;
               exit when Choix='a' or Choix='b' or Choix='c' or Choix='d';
               Put("Erreur saisie");
            end loop;
            case Choix is
               when 'a' => Saisie_Demande_Audit;
               when 'b' => Affiche_liste_audit;
               when 'c' => Affiche_audit_en_cours;
               when 'd' => exit;                                                                                     
            end case;
         
         when '4' => Put_Line("Bienvenue dans la partie gestion des archives");
            loop
               Put_line("Veuillez cliquer sur un des caracteres suivants");
               Put_Line("a => Telecharger les archives");
               Put_line("b => QUITTER..");
               Get(Choix);
               Skip_Line;
               exit when Choix='a' or Choix='b';
               Put_Line("Erreur saisie");
            end loop;
            case Choix is 
               when 'a' => Telecharger_Archive;
               when 'b' => exit;  
            end case;
         end case;
      end loop;            
   end Main_Project;
