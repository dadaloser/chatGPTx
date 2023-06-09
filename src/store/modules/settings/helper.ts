import { ss } from '@/utils/storage'
const LOCAL_NAME = 'settingsStorage'

export interface SettingsState {
  apiKey?: string
  accessToken?: string
  systemMessage: string
  temperature: number
  top_p: number
  frequency_penalty: number
  presence_penalty: number
  language_model: string
  user: string
  gptNickname: string // 给gpt起的名字
}

export function defaultSetting(): SettingsState {
  return {
    apiKey: '',
    accessToken: '',
    systemMessage: 'You are ChatGPT, a large language model trained by OpenAI. Follow the user\'s instructions carefully. Respond using markdown.',
    temperature: 0.8,
    top_p: 1,
    frequency_penalty: 0,
    presence_penalty: 0,
    language_model: 'gpt-3.5-turbo',
    user: 'default name',
    gptNickname: 'chatGPTx', // 给gpt起的名字
  }
}

export function getLocalState(): SettingsState {
  const localSetting: SettingsState | undefined = ss.get(LOCAL_NAME)
  return { ...defaultSetting(), ...localSetting }
}

export function setLocalState(setting: SettingsState): void {
  ss.set(LOCAL_NAME, setting)
}

export function removeLocalState() {
  ss.remove(LOCAL_NAME)
}
