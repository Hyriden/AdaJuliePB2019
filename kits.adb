with Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io;

package body Kit is

procedure Saisie_Kit (K : out T_Kit; D : T_Date) is
   Choix : integer;

begin
   Put_Line("Veuillez saisir la nature du kit");
   Put_Line("Tapez 1 pour Veterinaire");
   Put_Line("Tapez 2 pour Culture");
   Put_Line("Tapez 3 pour Microbiologie");
   Put_Line("Tapez 4 pour Controle");
   Get(Choix); New_Line;
   case Choix is
      when '1' => K.Nature := Veterinaire;
      when '2' => K.Nature := Culture;
      when '3' => K.Nature := Microbiologie;
      when '4' => K.Nature := Controle;
      when others => exit;
   end case;
   Put_Line("Veuillez saisir l'identifiant du kit");
   Get(K.Identifiant); new_line;
   Put_Line("Veuillez saisir la date de péremption du kit");
   Put_Line("Veuillez saisir le numéro du jour de la date de péremption du kit");
   Get(K.Date_peremption.D.J); New_Line;
   Put_Line("Veuillez saisir le mois de la date de péremption du kit");
   Get(K.Date_peremption.D.Mois); New_Line;
   Put_Line("Veuillez saisir l'année de la date de péremption du kit");
   Get(K.Date_Peremption.D.Annee); New_Line;
   case (K.Date_peremption.D.Mois) is 
      when "Fevrier" => 
         if K.Date_Peremption.D.Annee mod 400 = 0 and A mod 100 /= 0 and A mod 4 = 0 then K.Date_peremption.D.J =>1 and K.Date_peremption.D.J <=28;
         else K.Date_peremption.D.J>=1 and K.Date_peremption.D.J <=29;
         end if;
      when "Avril"|"Juin"|"Septembre"|"Novembre" => K.Date_peremption.D.J >=1 and K.Date_peremption.D.J <=30;
      when others => K.Date_peremption.D.J >=1 and K.Date_peremption.D.J <=31;
   end case;
   Put_Line("Veuillez indiquer si le kit est utilisé en ce moment ?"); -- nécéssaire ??
end Saisie_Kit;
--------------------------------------------------------------------------------------------   
-------------------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------------------- 
procedure Ajout_Kit (Tete : in out T_Liste_Kit; k : positive; Ki : T_Kit; Erreur : out Boolean) is

begin
   if K = 1 then 
      Erreur := False;
      Tete := new T_UnKit(Saisie_Kit(Ki, null)); -- droit de faire ça?
   elsif Tete = null then
      Erreur := True;
   else Ajout_Kit (Tete.Suiv, K-1, Ki, Erreur);
   end if;
end Ajout_Kit;
--------------------------------------------------------------------------------------------   
-------------------------------------------------------------------------------------------- 
-------------------------------------------------------------------------------------------- 
Function Suppr_Kit (K: in T_Kit; L: in out T_Liste_Kit; Ok : out Boolean) return Boolean is
   ok : boolean := false;
   Pt : T_Liste_Kit := L;
   id : interger;
begin -- est ce que c'est ici qu'on supprime egalement les kit dont la date de péremption est dépassé ?
   Ok := False;
   if K.Utilise = False then
      Put_Line("Veuillez saisir l'identifiant du kit à supprimer");
      Get(id); New_Line;
         if Pt /= null and then L.K.Identifiant /= id then Pt.suiv := Pt.suiv.suiv;
         else while Pt/= null loop and L.K.Identifiant = Id then Pt := Pt.Suiv;
         end loop;
         end if;
   end if;
   Ok :=True;
   return(Ok);
end Suppr_Kit;
--------------------------------------------------------------------------------------------   
-------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------
procedure Affiche_Kit (L : in T_Liste_Kit) is
   Pt : T_Liste_Kit := L;
begin
   while Pt /= null loop
      Put_Line("Nature du kit:"); Put(K.Nature);
      Put_Line("Identifiant du kit:"); Put(K.Identifiant);
      Put_Line("Nombre d'utilisation du kit:"); Put(K.Nb_Utilisation);
      Put_Line("Le kit est il utilisé"); Put(K.Utilise);
      Pt := Pt.Suiv;
   end loop;
End Affiche_Kit;
End Kit;