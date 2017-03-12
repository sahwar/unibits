require "unicode/categories"

module Unibits
  module Symbolify
    ASCII_CHARS = "\x20-\x7E".freeze
    ASCII_CONTROL_CODEPOINTS = "\x00-\x1F\x7F".freeze
    ASCII_CONTROL_SYMBOLS = "\u{2400}-\u{241F}\u{2421}".freeze

    CONTROL_C0_SYMBOLS = [
      "␀",
      "␁",
      "␂",
      "␃",
      "␄",
      "␅",
      "␆",
      "␇",
      "␈",
      "␉",
      "␊",
      "␋",
      "␌",
      "␍",
      "␎",
      "␏",
      "␐",
      "␑",
      "␒",
      "␓",
      "␔",
      "␕",
      "␖",
      "␗",
      "␘",
      "␙",
      "␚",
      "␛",
      "␜",
      "␝",
      "␞",
      "␟",
    ]

    CONTROL_DELETE_SYMBOL = "␡"

    CONTROL_C1_NAMES = {
      0x80 => "PAD",
      0x81 => "HOP",
      0x82 => "BPH",
      0x83 => "NBH",
      0x84 => "IND",
      0x85 => "NEL",
      0x86 => "SSA",
      0x87 => "ESA",
      0x88 => "HTS",
      0x89 => "HTJ",
      0x8A => "VTS",
      0x8B => "PLD",
      0x8C => "PLU",
      0x8D => "RI",
      0x8E => "SS2",
      0x8F => "SS3",
      0x90 => "DCS",
      0x91 => "PU1",
      0x92 => "PU2",
      0x93 => "STS",
      0x94 => "CCH",
      0x95 => "MW",
      0x96 => "SPA",
      0x97 => "EPA",
      0x98 => "SOS",
      0x99 => "SGC",
      0x9A => "SCI",
      0x9B => "CSI",
      0x9C => "ST",
      0x9D => "OSC",
      0x9E => "PM",
      0x9F => "APC",
    }

    INTERESTING_CODEPOINTS = {
      "\u{0080}" => "PAD",
      "\u{0081}" => "HOP",
      "\u{0082}" => "BPH",
      "\u{0083}" => "NBH",
      "\u{0084}" => "IND",
      "\u{0085}" => "NEL",
      "\u{0086}" => "SSA",
      "\u{0087}" => "ESA",
      "\u{0088}" => "HTS",
      "\u{0089}" => "HTJ",
      "\u{008A}" => "VTS",
      "\u{008B}" => "PLD",
      "\u{008C}" => "PLU",
      "\u{008D}" => "RI",
      "\u{008E}" => "SS2",
      "\u{008F}" => "SS3",
      "\u{0090}" => "DCS",
      "\u{0091}" => "PU1",
      "\u{0092}" => "PU2",
      "\u{0093}" => "STS",
      "\u{0094}" => "CCH",
      "\u{0095}" => "MW",
      "\u{0096}" => "SPA",
      "\u{0097}" => "EPA",
      "\u{0098}" => "SOS",
      "\u{0099}" => "SGC",
      "\u{009A}" => "SCI",
      "\u{009B}" => "CSI",
      "\u{009C}" => "ST",
      "\u{009D}" => "OSC",
      "\u{009E}" => "PM",
      "\u{009F}" => "APC",

      "\u{200E}" => "LRM",
      "\u{200F}" => "RLM",
      "\u{202A}" => "LRE",
      "\u{202B}" => "RLE",
      "\u{202C}" => "PDF",
      "\u{202D}" => "LRO",
      "\u{202E}" => "RLO",
      "\u{2066}" => "LRI",
      "\u{2067}" => "RLI",
      "\u{2068}" => "FSI",
      "\u{2069}" => "PDI",

      "\u{FE00}" => "VS1",
      "\u{FE01}" => "VS2",
      "\u{FE02}" => "VS3",
      "\u{FE03}" => "VS4",
      "\u{FE04}" => "VS5",
      "\u{FE05}" => "VS6",
      "\u{FE06}" => "VS7",
      "\u{FE07}" => "VS8",
      "\u{FE08}" => "VS9",
      "\u{FE09}" => "VS10",
      "\u{FE0A}" => "VS11",
      "\u{FE0B}" => "VS12",
      "\u{FE0C}" => "VS13",
      "\u{FE0D}" => "VS14",
      "\u{FE0E}" => "VS15",
      "\u{FE0F}" => "VS16",

      "\u{E0100}" => "VS17",
      "\u{E0101}" => "VS18",
      "\u{E0102}" => "VS19",
      "\u{E0103}" => "VS20",
      "\u{E0104}" => "VS21",
      "\u{E0105}" => "VS22",
      "\u{E0106}" => "VS23",
      "\u{E0107}" => "VS24",
      "\u{E0108}" => "VS25",
      "\u{E0109}" => "VS26",
      "\u{E010A}" => "VS27",
      "\u{E010B}" => "VS28",
      "\u{E010C}" => "VS29",
      "\u{E010D}" => "VS30",
      "\u{E010E}" => "VS31",
      "\u{E010F}" => "VS32",
      "\u{E0110}" => "VS33",
      "\u{E0111}" => "VS34",
      "\u{E0112}" => "VS35",
      "\u{E0113}" => "VS36",
      "\u{E0114}" => "VS37",
      "\u{E0115}" => "VS38",
      "\u{E0116}" => "VS39",
      "\u{E0117}" => "VS40",
      "\u{E0118}" => "VS41",
      "\u{E0119}" => "VS42",
      "\u{E011A}" => "VS43",
      "\u{E011B}" => "VS44",
      "\u{E011C}" => "VS45",
      "\u{E011D}" => "VS46",
      "\u{E011E}" => "VS47",
      "\u{E011F}" => "VS48",
      "\u{E0120}" => "VS49",
      "\u{E0121}" => "VS50",
      "\u{E0122}" => "VS51",
      "\u{E0123}" => "VS52",
      "\u{E0124}" => "VS53",
      "\u{E0125}" => "VS54",
      "\u{E0126}" => "VS55",
      "\u{E0127}" => "VS56",
      "\u{E0128}" => "VS57",
      "\u{E0129}" => "VS58",
      "\u{E012A}" => "VS59",
      "\u{E012B}" => "VS60",
      "\u{E012C}" => "VS61",
      "\u{E012D}" => "VS62",
      "\u{E012E}" => "VS63",
      "\u{E012F}" => "VS64",
      "\u{E0130}" => "VS65",
      "\u{E0131}" => "VS66",
      "\u{E0132}" => "VS67",
      "\u{E0133}" => "VS68",
      "\u{E0134}" => "VS69",
      "\u{E0135}" => "VS70",
      "\u{E0136}" => "VS71",
      "\u{E0137}" => "VS72",
      "\u{E0138}" => "VS73",
      "\u{E0139}" => "VS74",
      "\u{E013A}" => "VS75",
      "\u{E013B}" => "VS76",
      "\u{E013C}" => "VS77",
      "\u{E013D}" => "VS78",
      "\u{E013E}" => "VS79",
      "\u{E013F}" => "VS80",
      "\u{E0140}" => "VS81",
      "\u{E0141}" => "VS82",
      "\u{E0142}" => "VS83",
      "\u{E0143}" => "VS84",
      "\u{E0144}" => "VS85",
      "\u{E0145}" => "VS86",
      "\u{E0146}" => "VS87",
      "\u{E0147}" => "VS88",
      "\u{E0148}" => "VS89",
      "\u{E0149}" => "VS90",
      "\u{E014A}" => "VS91",
      "\u{E014B}" => "VS92",
      "\u{E014C}" => "VS93",
      "\u{E014D}" => "VS94",
      "\u{E014E}" => "VS95",
      "\u{E014F}" => "VS96",
      "\u{E0150}" => "VS97",
      "\u{E0151}" => "VS98",
      "\u{E0152}" => "VS99",
      "\u{E0153}" => "VS100",
      "\u{E0154}" => "VS101",
      "\u{E0155}" => "VS102",
      "\u{E0156}" => "VS103",
      "\u{E0157}" => "VS104",
      "\u{E0158}" => "VS105",
      "\u{E0159}" => "VS106",
      "\u{E015A}" => "VS107",
      "\u{E015B}" => "VS108",
      "\u{E015C}" => "VS109",
      "\u{E015D}" => "VS110",
      "\u{E015E}" => "VS111",
      "\u{E015F}" => "VS112",
      "\u{E0160}" => "VS113",
      "\u{E0161}" => "VS114",
      "\u{E0162}" => "VS115",
      "\u{E0163}" => "VS116",
      "\u{E0164}" => "VS117",
      "\u{E0165}" => "VS118",
      "\u{E0166}" => "VS119",
      "\u{E0167}" => "VS120",
      "\u{E0168}" => "VS121",
      "\u{E0169}" => "VS122",
      "\u{E016A}" => "VS123",
      "\u{E016B}" => "VS124",
      "\u{E016C}" => "VS125",
      "\u{E016D}" => "VS126",
      "\u{E016E}" => "VS127",
      "\u{E016F}" => "VS128",
      "\u{E0170}" => "VS129",
      "\u{E0171}" => "VS130",
      "\u{E0172}" => "VS131",
      "\u{E0173}" => "VS132",
      "\u{E0174}" => "VS133",
      "\u{E0175}" => "VS134",
      "\u{E0176}" => "VS135",
      "\u{E0177}" => "VS136",
      "\u{E0178}" => "VS137",
      "\u{E0179}" => "VS138",
      "\u{E017A}" => "VS139",
      "\u{E017B}" => "VS140",
      "\u{E017C}" => "VS141",
      "\u{E017D}" => "VS142",
      "\u{E017E}" => "VS143",
      "\u{E017F}" => "VS144",
      "\u{E0180}" => "VS145",
      "\u{E0181}" => "VS146",
      "\u{E0182}" => "VS147",
      "\u{E0183}" => "VS148",
      "\u{E0184}" => "VS149",
      "\u{E0185}" => "VS150",
      "\u{E0186}" => "VS151",
      "\u{E0187}" => "VS152",
      "\u{E0188}" => "VS153",
      "\u{E0189}" => "VS154",
      "\u{E018A}" => "VS155",
      "\u{E018B}" => "VS156",
      "\u{E018C}" => "VS157",
      "\u{E018D}" => "VS158",
      "\u{E018E}" => "VS159",
      "\u{E018F}" => "VS160",
      "\u{E0190}" => "VS161",
      "\u{E0191}" => "VS162",
      "\u{E0192}" => "VS163",
      "\u{E0193}" => "VS164",
      "\u{E0194}" => "VS165",
      "\u{E0195}" => "VS166",
      "\u{E0196}" => "VS167",
      "\u{E0197}" => "VS168",
      "\u{E0198}" => "VS169",
      "\u{E0199}" => "VS170",
      "\u{E019A}" => "VS171",
      "\u{E019B}" => "VS172",
      "\u{E019C}" => "VS173",
      "\u{E019D}" => "VS174",
      "\u{E019E}" => "VS175",
      "\u{E019F}" => "VS176",
      "\u{E01A0}" => "VS177",
      "\u{E01A1}" => "VS178",
      "\u{E01A2}" => "VS179",
      "\u{E01A3}" => "VS180",
      "\u{E01A4}" => "VS181",
      "\u{E01A5}" => "VS182",
      "\u{E01A6}" => "VS183",
      "\u{E01A7}" => "VS184",
      "\u{E01A8}" => "VS185",
      "\u{E01A9}" => "VS186",
      "\u{E01AA}" => "VS187",
      "\u{E01AB}" => "VS188",
      "\u{E01AC}" => "VS189",
      "\u{E01AD}" => "VS190",
      "\u{E01AE}" => "VS191",
      "\u{E01AF}" => "VS192",
      "\u{E01B0}" => "VS193",
      "\u{E01B1}" => "VS194",
      "\u{E01B2}" => "VS195",
      "\u{E01B3}" => "VS196",
      "\u{E01B4}" => "VS197",
      "\u{E01B5}" => "VS198",
      "\u{E01B6}" => "VS199",
      "\u{E01B7}" => "VS200",
      "\u{E01B8}" => "VS201",
      "\u{E01B9}" => "VS202",
      "\u{E01BA}" => "VS203",
      "\u{E01BB}" => "VS204",
      "\u{E01BC}" => "VS205",
      "\u{E01BD}" => "VS206",
      "\u{E01BE}" => "VS207",
      "\u{E01BF}" => "VS208",
      "\u{E01C0}" => "VS209",
      "\u{E01C1}" => "VS210",
      "\u{E01C2}" => "VS211",
      "\u{E01C3}" => "VS212",
      "\u{E01C4}" => "VS213",
      "\u{E01C5}" => "VS214",
      "\u{E01C6}" => "VS215",
      "\u{E01C7}" => "VS216",
      "\u{E01C8}" => "VS217",
      "\u{E01C9}" => "VS218",
      "\u{E01CA}" => "VS219",
      "\u{E01CB}" => "VS220",
      "\u{E01CC}" => "VS221",
      "\u{E01CD}" => "VS222",
      "\u{E01CE}" => "VS223",
      "\u{E01CF}" => "VS224",
      "\u{E01D0}" => "VS225",
      "\u{E01D1}" => "VS226",
      "\u{E01D2}" => "VS227",
      "\u{E01D3}" => "VS228",
      "\u{E01D4}" => "VS229",
      "\u{E01D5}" => "VS230",
      "\u{E01D6}" => "VS231",
      "\u{E01D7}" => "VS232",
      "\u{E01D8}" => "VS233",
      "\u{E01D9}" => "VS234",
      "\u{E01DA}" => "VS235",
      "\u{E01DB}" => "VS236",
      "\u{E01DC}" => "VS237",
      "\u{E01DD}" => "VS238",
      "\u{E01DE}" => "VS239",
      "\u{E01DF}" => "VS240",
      "\u{E01E0}" => "VS241",
      "\u{E01E1}" => "VS242",
      "\u{E01E2}" => "VS243",
      "\u{E01E3}" => "VS244",
      "\u{E01E4}" => "VS245",
      "\u{E01E5}" => "VS246",
      "\u{E01E6}" => "VS247",
      "\u{E01E7}" => "VS248",
      "\u{E01E8}" => "VS249",
      "\u{E01E9}" => "VS250",
      "\u{E01EA}" => "VS251",
      "\u{E01EB}" => "VS252",
      "\u{E01EC}" => "VS253",
      "\u{E01ED}" => "VS254",
      "\u{E01EE}" => "VS255",
      "\u{E01EF}" => "VS256",
    }.freeze

    TAG_START = "\u{E0001}".freeze
    TAG_START_SYMBOL = "LANG TAG".freeze
    TAG_SPACE = "\u{E0020}".freeze
    TAG_SPACE_SYMBOL = "TAG ␠".freeze
    TAGS = "\u{E0021}-\u{E007E}".freeze
    TAG_DELETE = "\u{E007F}".freeze
    TAG_DELETE_SYMBOL = "TAG ␡".freeze

    BLANKS = '[\p{Space}­ᅟᅠ᠎​‌‍⁠⁡⁢⁣⁤⁪⁫⁬⁭⁮⁯ㅤ⠀﻿𛲠𛲡𛲢𛲣𝅙𝅳𝅴𝅵𝅶𝅷𝅸𝅹𝅺]'.freeze

    def self.symbolify(char, char_info)
      if !char_info.valid?
        "�"
      else
        case char_info
        when UnicodeCharInfo
          Symbolify.unicode(char, char_info)
        when ByteCharInfo
          Symbolify.byte(char, char_info)
        when AsciiCharInfo
          Symbolify.ascii(char, char_info)
        else
          Symbolify.binary(char)
        end
      end
    end

    def self.unicode(char, char_info)
      return "n/a" if !char_info.assigned?

      char = char.dup
      encoding = char_info.encoding

      # control
      char.tr!(
        ASCII_CONTROL_CODEPOINTS.encode(encoding),
        ASCII_CONTROL_SYMBOLS.encode(encoding)
      )

      INTERESTING_CODEPOINTS.each{ |cp, desc|
        char.gsub! Regexp.compile(cp.encode(encoding)), desc.encode(encoding)
      }

      # whitespace
      char.gsub!(
        Regexp.compile(BLANKS.encode(encoding)),
        ']\0['.encode(encoding)
      )

      # tags
      char.gsub! TAG_START.encode(encoding), TAG_START_SYMBOL.encode(encoding)
      char.gsub! TAG_SPACE.encode(encoding), TAG_SPACE_SYMBOL.encode(encoding)
      char.gsub! TAG_DELETE.encode(encoding), TAG_DELETE_SYMBOL.encode(encoding)

      ord = char.ord
      if ord > 917536 && ord < 917631
        char.tr!(TAGS.encode(encoding), ASCII_CHARS.encode(encoding))
        char = "TAG ".encode(encoding) + char
      end

      char.encode("UTF-8")
    end

    def self.byte(char, char_info)
      return "n/a" if !char_info.assigned?

      ord = char.ord
      encoding = char_info.encoding

      if char_info.delete?
        char = CONTROL_DELETE_SYMBOL
      elsif char_info.c0?
        char = CONTROL_C0_SYMBOLS[ord]
      elsif char_info.c1?
        char = CONTROL_C1_NAMES[ord]
      elsif char_info.blank?
        char = "]".encode(encoding) + char + "[".encode(encoding)
      end

      char.encode("UTF-8")
    end

    def self.ascii(char, char_info)
      if char_info.delete?
        char = CONTROL_DELETE_SYMBOL
      elsif char_info.c0?
        char = CONTROL_C0_SYMBOLS[ord]
      elsif char_info.blank?
        char = "]" + char + "["
      end

      char
    end

    def self.binary(char)
      char.inspect
    end
  end
end
