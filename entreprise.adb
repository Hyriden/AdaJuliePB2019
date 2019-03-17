with Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io;

package body Entreprise is

procedure Saisie_Entreprise (E : out T_Emptreprise; D : T_Date) is
   Choix : integer;

begin 
   Put_Line("Veuillez saisir le nom de l'entreprise");
   Get_Line(E.Nom); New_Line;
   Put_Line("Veuillez saisir la date du dernier audit");
   Put_Line("Veuillez saisir le numéro du jour de la date du dernier audit");
   Get(E.Date_dernier_audit.D.J); New_Line;
   Put_Line("Veuillez saisir le mois de la date du dernier audit");
   Get(E.Date_dernier_audit.D.Mois); New_Line;
   Put_Line("Veuillez saisir l'année de la date du dernier audit");
   Get(E.Date_dernier_audit.D.Annee); New_Line;
   case (E.Date_dernier_audit.D.Mois) is 
      when "Fevrier" => 
         if E.Date_dernier_audit.D.Annee mod 400 = 0 and A mod 100 /= 0 and A mod 4 = 0 then E.Date_dernier_audit.D.J =>1 and E.Date_dernier_audit.D.J <=28;
         else E.Date_dernier_audit.D.J>=1 and E.Date_dernier_audit.D.J <=29;
         end if;
      when "Avril"|"Juin"|"Septembre"|"Novembre" => E.Date_dernier_audit.D.J >=1 and E.Date_dernier_audit.D.J <=30;
      when others => E.Date_dernier_audit.D.J >=1 and E.Date_dernier_audit.D.J <=31;
   end case;
   Put_Line("Veuillez saisir le résulat du dernier audit");
   Put-Line("Tapez 1 pour Positif");
   Put-Line("Tapez 2 pour Négatif");
   Put_Line("Tapez 3 pour Problématique");
   Get(Choix); New_Line;
   case Choix is
      when '1' => E.Resulat_Dernier_Audit := Positif;
      when '2' => E.Resulat_Dernier_Audit := Negatif;
      when '3' => E.Resulat_Dernier_Audit := Problematique;
   end case;
end Saisie_Entreprise;
--------------------------------------------------------------------------------------------   
-------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------
procedure Ajout_Entreprise (Tete : in out T_Liste_Entreprise; K : Positive; E : T_Entreprise; Erreur : out Boolean) is

begin
   if K = 1 then
      Erreur := False;
      Tete := new T_Uneentreprise(Saisie_Entreprise(E, null)); -- on peut faire ça ?
   elsif Tete = null then
      Erreur := True;
   else Ajout_Kit (Tete.Suiv, K-1, E, Erreur);
   end if;
End Ajout_Entreprise;
--------------------------------------------------------------------------------------------   
-------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------
function Suppr_Entreprise (E : in T_Entreprise; L: in out L_Liste_Entreprise; Ok : out Boolean) return Boolean is
   Ok : Boolean := False;
   Pt : T_Liste_Entreprise := L;
   Nom_E : T_Mot;
begin
   Ok := False;
   Put_Line("Veuillez saisir le nom de l'entreprise à supprimer");
   Get_Line(Nom_E); New_Line;
      if Pt /= null and then L.E.Nom /= Nom_E then Pt.Suiv := Pt.Suiv.Suiv;
      else while Pt/= null loop and L.E.Nom = Nom_E then Pt := Pt.Suiv;
      end loop;   
      end if;
   end if;
   Ok := True;
   return(Ok);
end Suppr_Entreprise;
--------------------------------------------------------------------------------------------   
-------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------
  
      
   
