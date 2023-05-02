<script lang="ts" setup>
import { ref } from 'vue'

import { NButton, NInput, NSlider, useMessage } from 'naive-ui'
import { useSettingStore } from '@/store'
import type { SettingsState } from '@/store/modules/settings/helper'
import { t } from '@/locales'

const settingStore = useSettingStore()

const ms = useMessage()

const systemMessage = ref(settingStore.systemMessage ?? '')

const temperature = ref(settingStore.temperature ?? 0.5)

const top_p = ref(settingStore.top_p ?? 1)

const frequency_penalty = ref(settingStore.frequency_penalty ?? 0)

const presence_penalty = ref(settingStore.presence_penalty ?? 0)

const language_model = ref(settingStore.language_model ?? 'gpt-3.5-turbo')

const languageModelOptions: { key: string; value: string }[] = [
  { key: 'gpt-3.5-turbo', value: 'gpt-3.5-turbo' },
  { key: 'gpt-4', value: 'gpt-4' },
]

const gptNickName = ref(settingStore.gptNickName ?? '')

function updateSettings(options: Partial<SettingsState>) {
  settingStore.updateSetting(options)
  ms.success(t('common.success'))
}

function handleReset() {
  settingStore.resetSetting()
  ms.success(t('common.success'))
  window.location.reload()
}
</script>

<template>
  <div class="p-4 space-y-5 min-h-[200px]">
    <div class="space-y-6">
      <div class="flex items-center space-x-4">
        <span class="flex-shrink-0 w-[120px]">{{ $t('setting.gptNickName') }}</span>
        <div class="w-[200px]">
          <NInput v-model:value="gptNickName" placeholder="" />
        </div>
      </div>
      <div class="flex items-center space-x-4">
        <span class="flex-shrink-0 w-[120px]">{{ $t('setting.languageModel') }}</span>
        <div class="flex flex-wrap items-center gap-4">
          <template v-for="item of languageModelOptions" :key="item.key">
            <NButton
              v-model:value="language_model"
              size="small"
              :type="item.key === language_model ? 'primary' : undefined"
            >
              {{ $t(item.value) }}
            </NButton>
          </template>
        </div>
      </div>
      <div class="flex items-center space-x-4">
        <span class="flex-shrink-0 w-[120px]">{{ $t('setting.roleCharacter') }}</span>
        <div class="flex-1">
          <NInput v-model:value="systemMessage" type="textarea" :autosize="{ minRows: 1, maxRows: 4 }" />
        </div>
      </div>
      <div class="flex items-center space-x-4">
        <span class="flex-shrink-0 w-[120px]">{{ $t('setting.temperature') }} </span>
        <div class="flex-1">
          <NSlider v-model:value="temperature" :max="2" :min="0" :step="0.1" />
        </div>
        <span class="flex-shrink-0 w-[30px]">{{ temperature }}</span>
      </div>
      <div class="flex items-center space-x-4">
        <span class="flex-shrink-0 w-[120px]">{{ $t('setting.top_p') }} </span>
        <div class="flex-1">
          <NSlider v-model:value="top_p" :max="1" :min="0" :step="0.1" />
        </div>
        <span class="flex-shrink-0 w-[30px]">{{ top_p }}</span>
      </div>
      <div class="flex items-center space-x-4">
        <span class="flex-shrink-0 w-[120px]">{{ $t('setting.frequencyPenalty') }} </span>
        <div class="flex-1">
          <NSlider v-model:value="frequency_penalty" :max="2" :min="-2" :step="0.1" />
        </div>
        <span class="flex-shrink-0 w-[30px]">{{ frequency_penalty }}</span>
      </div>
      <div class="flex items-center space-x-4">
        <span class="flex-shrink-0 w-[120px]">{{ $t('setting.presencePenalty') }} </span>
        <div class="flex-1">
          <NSlider v-model:value="presence_penalty" :max="2" :min="-2" :step="0.1" />
        </div>
        <span class="flex-shrink-0 w-[30px]">{{ presence_penalty }}</span>
      </div>
      <div class="flex items-center justify-center space-x-4 ">
        <NButton size="small" @click="updateSettings({ systemMessage, temperature, top_p, frequency_penalty, presence_penalty, language_model, gptNickName })">
          {{ $t('common.save') }}
        </NButton>
        <NButton size="small" @click="handleReset">
          {{ $t('common.reset') }}
        </NButton>
      </div>
    </div>
  </div>
</template>
