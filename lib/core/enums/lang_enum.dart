enum LangEnum {
  en,
  ar;

  String get value {
    switch (this) {
      case LangEnum.en:
        return 'en';
      case LangEnum.ar:
        return 'ar';
    }
  }
}
