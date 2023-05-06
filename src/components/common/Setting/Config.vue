<script lang="ts" setup>
import { ref } from 'vue'

import { NButton, NInput, useMessage } from 'naive-ui'
import { useSettingStore } from '@/store'
import type { SettingsState } from '@/store/modules/settings/helper'
import { t } from '@/locales'

const settingStore = useSettingStore()

const ms = useMessage()

const gptNickname = ref(settingStore.gptNickname ?? '')

const language_model = ref(settingStore.language_model ?? 'gpt-3.5-turbo')

const languageModelOptions: { key: string; value: string }[] = [
  { key: 'gpt-3.5-turbo', value: 'gpt-3.5-turbo' },
  { key: 'gpt-4', value: 'gpt-4' },
]

const systemMessage = ref(settingStore.systemMessage ?? '')

const apiKey = ref(settingStore.apiKey ?? '')

const accessToken = ref(settingStore.accessToken ?? '')

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
        <span class="flex-shrink-0 w-[100px]">{{ $t('setting.gptNickname') }}</span>
        <div class="w-[200px]">
          <NInput v-model:value="gptNickname" :placeholder="t('setting.gptNicknamePlaceholder')" />
        </div>
      </div>
      <div class="flex items-center space-x-4">
        <span class="flex-shrink-0 w-[100px]">{{ $t('setting.languageModel') }}</span>
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
        <span class="flex-shrink-0 w-[100px]">{{ $t('setting.roleCharacter') }}</span>
        <div class="flex-1">
          <NInput v-model:value="systemMessage" type="textarea" :autosize="{ minRows: 1, maxRows: 4 }" />
        </div>
      </div>

      <div class="flex items-center space-x-4">
        <span class="flex-shrink-0 w-[100px]">{{ $t('setting.apiKey') }}</span>
        <div class="flex-1">
          <NInput v-model:value="apiKey" type="password" placeholder="Api Key" />
        </div>
      </div>
      <div class="flex items-center space-x-4">
        <span class="flex-shrink-0 w-[100px]">{{ $t('setting.accessToken') }}</span>
        <div class="flex-1">
          <NInput v-model:value="accessToken" type="password" :placeholder="t('setting.accessToken')" />
        </div>
      </div>

      <div class="flex items-center justify-center space-x-4 ">
        <NButton size="small" @click="updateSettings({ gptNickname, systemMessage, language_model, apiKey, accessToken })">
          {{ $t('common.save') }}
        </NButton>
        <NButton size="small" @click="handleReset">
          {{ $t('common.reset') }}
        </NButton>
      </div>
    </div>
  </div>
</template>
