{ pkgs, ... }:

let
  canary_eng = toString (
    pkgs.writeText "canary_eng" ''
      xkb_symbols "canary" {
          include "us(basic)"

          key <AD01> {[ w, W ]};
          key <AD02> {[ l, L ]};
          key <AD03> {[ y, Y ]};
          key <AD04> {[ p, P ]};
          key <AD05> {[ k, K ]};
          key <AD06> {[ z, Z ]};
          key <AD07> {[ x, X ]};
          key <AD08> {[ o, O ]};
          key <AD09> {[ u, U ]};
          key <AD10> {[ semicolon, colon ]};
          key <AC01> {[ c, C ]};
          key <AC02> {[ r, R ]};
          key <AC03> {[ s, S ]};
          key <AC04> {[ t, T ]};
          key <AC05> {[ b, B ]};
          key <AC06> {[ f, F ]};
          key <AC07> {[ n, N ]};
          key <AC08> {[ e, E ]};
          key <AC09> {[ i, I ]};
          key <AC10> {[ a, A ]};
          key <AC11> {[ apostrophe, quotedbl ]};
          key <AB01> {[ j, J ]};
          key <AB02> {[ v, V ]};
          key <AB03> {[ d, D ]};
          key <AB04> {[ g, G ]};
          key <AB05> {[ q, Q ]};
          key <AB06> {[ m, M ]};
          key <AB07> {[ h, H ]};
          key <AB08> {[ slash, question ]};
          key <AB09> {[ comma, less ]};
          key <AB10> {[ period, greater ]};
      };
    ''
  );

  canary_ru = toString (
    pkgs.writeText "canary_ru" ''
      xkb_symbols "canary_ru" {
          include "ru(basic)"

          key <AD01> {[ ц, Ц ]};  // w -> ц
          key <AD02> {[ л, Л ]};  // l -> л
          key <AD03> {[ ы, Ы ]};  // y -> ы
          key <AD04> {[ п, П ]};  // p -> п
          key <AD05> {[ к, К ]};  // k -> к
          key <AD06> {[ з, З ]};  // z -> з
          key <AD07> {[ х, Х ]};  // x -> х
          key <AD08> {[ о, О ]};  // o -> о
          key <AD09> {[ у, У ]};  // u -> у
          key <AD10> {[ ж, Ж ]};  // ; -> ж
          key <AC01> {[ с, С ]};  // c -> с
          key <AC02> {[ р, Р ]};  // r -> р
          key <AC03> {[ ы, Ы ]};  // s -> ы
          key <AC04> {[ т, Т ]};  // t -> т
          key <AC05> {[ б, Б ]};  // b -> б
          key <AC06> {[ ф, Ф ]};  // f -> ф
          key <AC07> {[ н, Н ]};  // n -> н
          key <AC08> {[ е, Е ]};  // e -> е
          key <AC09> {[ и, И ]};  // i -> и
          key <AC10> {[ а, А ]};  // a -> а
          key <AC11> {[ э, Э ]};  // ' -> э
          key <AB01> {[ й, Й ]};  // j -> й
          key <AB02> {[ в, В ]};  // v -> в
          key <AB03> {[ д, Д ]};  // d -> д
          key <AB04> {[ г, Г ]};  // g -> г
          key <AB05> {[ я, Я ]};  // q -> я
          key <AB06> {[ м, М ]};  // m -> м
          key <AB07> {[ ч, Ч ]};  // h -> ч
          key <AB08> {[ щ, Щ ]};  // / -> щ
          key <AB09> {[ б, Б ]};  // , -> б
          key <AB10> {[ ю, Ю ]};  // . -> ю
      };
    ''
  );

in
{
  services.xserver = {
    xkb = {
      layout = "canary";
      extraLayouts.canary = {
        description = "canary";
        languages = [ "eng" ];
        symbolsFile = canary_eng;
      };
      extraLayouts.canary_ru = {
        description = "canary_ru"; # TODO: layout is broken
        languages = [ "rus" ];
        symbolsFile = canary_ru;
      };
    };
  };
  console.useXkbConfig = true;
}
