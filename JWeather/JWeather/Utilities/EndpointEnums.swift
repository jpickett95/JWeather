//
//  EndpointEnums.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/4/24.
//

// MARK: Units
enum Unit: String {
    case metric = "metric"
    case imperial = "imperial"
}

// MARK: Exclusions
enum Exclusion: String {
    case current = "current"
    case minutely = "minutely"
    case hourly = "hourly"
    case daily = "daily"
    case alerts = "alerts"
}

// MARK: Languages
enum Language: String {
    case Albanian = "sq"
    case Afrikaans = "af"
    case Arabic = "ar"
    case Azerbaijani = "az"
    case Basque = "eu"
    case Belarusian = "be"
    case Bulgarian = "bg"
    case Catalan = "ca"
    case ChineseSimplified = "zh_cn"
    case ChineseTraditional = "zh_tw"
    case Croatian = "hr"
    case Czech = "cz"
    case Danish = "da"
    case Dutch = "nl"
    case English = "en"
    case Finnish = "fi"
    case French = "fr"
    case Galician = "gl"
    case German = "de"
    case Greek = "el"
    case Hebrew = "he"
    case Hindi = "hi"
    case Hungarian = "hu"
    case Icelandic = "is"
    case Indonesian = "id"
    case Italian = "it"
    case Japanese = "ja"
    case Korean = "kr"
    case Kurmanji = "ku"
    case Latvian = "la"
    case Lithuanian = "lt"
    case Macedonian = "mk"
    case Norwegian = "no"
    case Persian = "fa"
    case Polish = "pl"
    case Portuguese = "pt"
    case PortugueseBrazilian = "pt_br"
    case Romanian = "ro"
    case Russian = "ru"
    case Serbian = "sr"
    case Slovak = "sk"
    case Slovenian = "sl"
    case Spanish = "sp"
    case SpanishES = "es"
    case Swedish = "sv"
    case SwedishSE = "se"
    case Thai = "th"
    case Turkish = "tr"
    case Ukrainian = "ua"
    case UkrainianUK = "uk"
    case Vietnamese = "vi"
    case Zulu = "zu"
}
