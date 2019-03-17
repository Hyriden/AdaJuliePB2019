with Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io;

Package body Employes is

procedure Saisie_Employe (E: out T_Employe; D: T_Date) is
   Choix : Integer;
   Choix2 : Integer;
   Choix3 : Integer;
   
Begin
   Put_line("Veuillez saisir le nom de l'employé");
   Get_Line(E.NomE); New_Line;
   Put_line("Veuillez saisir le prénom de l'employé");
   Get_Line(E.PrenomE); New_Line;
   Put_line("Veuillez saisir la profession de l'employé : Tapez 1 -> pour technicien et 2 -> pour ingénieur");
   Get(Choix); Skip_Line;
   Case choix is
      When '1' => E.Profession := Technicien;
      when '2' => E.Profession := Ingenieur;
      when others => Put_Line("Veuillez réessayer"); exit;
   end case;
   -- pas tres sure de cette partie
   Put_Line("Veuillez sasir si l'employé est en congé ou non : Tapez 3 -> si l'employé n'est oas en congé et 4 -> si l'employé est en congé");
   Get(Choix2); Skip_Line;
   case Choix2 is
      when '3' => E.Retour := Pasconge.Annee = 0; 
      when '4' =>  -- comment éviter les 31 Février ??
            Put_Line("Veuillez saisir la date de retour de congé de l'employé");          
            Put_Line("Veuillez saisir le numéro du jour");
            Get(D.J); Skip_Line;
            Put_Line("Veuillez saisir le mois");
            Get_Line(D.Mois); Skip_Line;
            Put_Line("Veuillez saisir l'année");     
            Get(D.Annee); slip_line;                  
               case (D.Mois) is 
                  when "Fevrier" => 
                     if D.Annee mod 400 = 0 and A mod 100 /= 0 and A mod 4 = 0 then D.J=>1 and D.J <=28;
                     else D.J>=1 and D.J <=29;
                     end if;
                  when "Avril"|"Juin"|"Septembre"|"Novembre" => D.J >=1 and D.J <=30;
                  when others => D.J >=1 and D.J <=31;
               end case;
        when others => Put_Line("Veuillez réessayer"); exit;
   end case;
    Put_Line("Veuillez préciser si l'employé travaille sur une audit actuellement : tapez 5 -> pour oui et 6 -> pour non");
    Get(Choix3); Skip_Line;  
   Case Choix3 is
       when '5' => E.Disponible := false;
       when '6'=> E.Disponible := true;
       when others => Put_Line("Veuillez réessayer") exit;
   end case; 
    --nombre de jour d'audit de l'employé ?? se fait "automatiquement"" ??    
   -- fin de la partie pas tres sure
 end Saisie_Employe;
---------------------------------------------------------------------------------------         
---------------------------------------------------------------------------------------  
---------------------------------------------------------------------------------------  
Procedure Recrutement (Tete : in out T_Liste_Employe; k : positive; E : T_Employe; Erreur : out Boolean) is
-- est ce qu'on fait une fonction qui reourne un boolean si ça c'est bien Passé ?
begin
   if k = 1 then
      erreur := false;
      Tete := new T_Unemploye(Saisie_Employe(E,null)); 
      ---> est ce qu'on a le droit de faire ça : appeler notre procedure saisie comme la ligne du haut
   elsif Tete = Null then 
      Erreur := True;
   else Recrutement (Tete.Suiv, K-1,E,Erreur);
   end if;
end Recrutement;
---------------------------------------------------------------------------------------         
---------------------------------------------------------------------------------------  
---------------------------------------------------------------------------------------      
Procedure Depart (E: in T_Employe; L: in out T_Liste_Employe); --N,P : T_Mot; Ok : out boolean) return boolean is   --> doute Pour N et P
   N : T_Mot;
   P : T_Mot;
   Pt : T_Liste_Employe := L;
begin
   ok := false;
   Put_Line("Veuillez saisir le nom de l'employé qui part");
   Get_Line(S,K); New_Line;
   N := T_Mot'value (s(1..k)); new_line; --> est ce que c'est juste ??
   Put_Line("Veuilez saisir le prenom de l'employé qui part");
   Get_Line(S,K); New_Line;
   P := T_Mot'Value (S(1..K)); New_Line; 
         if Pt /= null and then L.E.Nome /= N and then L.E.Prenome /= P then Pt := Pt.Suiv;
         else while Pt/= null loop and then L.E.Nome = N and L.E.Prenome = P and L.E.Disponible := True and L.E.Retour = Pasconge then Pt := Pt.Suiv;
         -- je viens d'avancer le pointeur de tete donc la cellule est détachée (est ce quie je dois faire ça où je mets les champs en ' ') ?
         end if;
   end loop;
   Ok := True;
   return(ok);
end Depart;
---------------------------------------------------------------------------------------         
---------------------------------------------------------------------------------------  
---------------------------------------------------------------------------------------         
procedure Affiche_Employes (L: in T_Liste_Employe) is
   Pt : T_Liste_Employe := L;
begin
   while Pt /= null loop
      Put_Line("Nom :"); put(E.Nome); Put("Prénom:"); put(E.Prenome); Put"Profession:"); Put(E.Profession); New_Line;
      Pt := Pt.Suiv;
   end loop;
End Affiche_Employes;
---------------------------------------------------------------------------------------         
---------------------------------------------------------------------------------------  
---------------------------------------------------------------------------------------       
function Depart_Conges (E: in T_Unemploye; L: in out T_Liste_Employe; D : T_Date) return Boolean is
   Ok : Boolean := False;
   Nn : T_Mot;
   Pn : T_Mot;
   Pt : T_Liste_Employe := L;

begin
   Ok := False;
   Put_Line("Veuillez saisir le nom de l'employé qui part");
   Get_Line(S,K); New_line;
   Nn := T_Mot'value (s(1..k)); new_line; --> est ce que c'est juste ??
   Put_Line("Veuilez saisir le prenom de l'employé qui part");
   Get_Line(S,K); New_Line;
   Pn := T_Mot'Value (S(1..K)); New_Line;
   if Pt /= null and then L.E.Nome /= N and then L.E.Prenome /= P then Pt := Pt.Suiv;
   else while Pt/= null loop and then L.E.Nome = N and L.E.Prenome = P and L.E.Disponible := True and L.E.Retour = Pasconge then
   -- est ce que c'es nécéssaire de mettre la date de départ ?
   -- comment calculer le nombre de jour entre le départ et k'arrivée ??
      Put_line("Veuillez saisir la date de départ en congés");
      Put_Line("Veuillez saisir le numéro du jour de la date de départ en congé");
         Get(D.J); Skip_Line;
      Put_Line("Veuillez saisir le mois de la date de départ en congé");
         Get_Line(D.Mois); Skip_Line;
      Put_Line("Veuillez saisir l'année de la date de départ en congé");
         Get(D.Annee); Slip_Line;
      case (D.Mois) is 
         when "Fevrier" => 
            if D.Annee mod 400 = 0 and A mod 100 /= 0 and A mod 4 = 0 then D.J=>1 and D.J <=28;
            else D.J>=1 and D.J <=29;
            end if;
         when "Avril"|"Juin"|"Septembre"|"Novembre" => D.J >=1 and D.J <=30;
         when others => D.J >=1 and D.J <=31;
      end case;      
      Put_line("Veuillez saisir la date de retour de congés");
      Put_Line("Veuillez saisir le numéro du jour de la date de retour de congé");
          Get(Retour.D.J); New_Line;
      Put_Line("Veuillez saisir le mois de la date de retour de congé");
          Get(Retour.D.Mois); New_Line;   
      Put_Line("Veuillez saisir l'année de la date de retour de congé");
          Get(Retour.D.Annee); New_Line;
      case (D.Mois) is 
         when "Fevrier" => 
            if D.Annee mod 400 = 0 and A mod 100 /= 0 and A mod 4 = 0 then D.J=>1 and D.J <=28;
            else D.J>=1 and D.J <=29;
            end if;
         when "Avril"|"Juin"|"Septembre"|"Novembre" => D.J >=1 and D.J <=30;
         when others => D.J >=1 and D.J <=31;
     end case;
   end loop;
   end if;
   ok :=true;
   -- donnee une valeur à la date retour : est ce que c'est juste ?
         L.E.Retour.D.J := Retour.D.J;
         L.E.Retour.D.Mois := Retour.D.Mois;
         L.E.Retour.D.Annee := Retour.D.Annee;
   -- dire que à partir de la date de départ la personne est en congé, crée un champ date de départ ? se gere avec le passage au lendemAin ?
   return(ok);
End Depart_Conges;
end Employes;
