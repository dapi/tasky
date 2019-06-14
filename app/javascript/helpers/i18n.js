import i18n from "i18next"
import { initReactI18next } from "react-i18next"

const resources = {
  ru: {
    translation: require('react-trello/locales/ru/translation.json')
  }
}

i18n
  .use(initReactI18next) // passes i18n down to react-i18next
  .init({
    resources,
    lng: "ru",
    debug: true,
    react: {
      useSuspense: false
    }})

export default i18n
