<script lang="ts" setup>
import { ref } from 'vue'

import { NButton, NSlider, useMessage } from 'naive-ui'
import { useSettingStore } from '@/store'
import type { SettingsState } from '@/store/modules/settings/helper'
import { t } from '@/locales'

const settingStore = useSettingStore()

const ms = useMessage()

const temperature = ref(settingStore.temperature ?? 0.5)

const top_p = ref(settingStore.top_p ?? 1)

const frequency_penalty = ref(settingStore.frequency_penalty ?? 0)

const presence_penalty = ref(settingStore.presence_penalty ?? 0)

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
        <span class="flex-shrink-0 w-[100px]">{{ $t('setting.temperature') }} </span>
        <div class="flex-1">
          <NSlider v-model:value="temperature" :max="2" :min="0" :step="0.1" />
        </div>
        <span class="flex-shrink-0 w-[30px]">{{ temperature }}</span>
      </div>
      <div class="flex items-center space-x-4">
        <span class="flex-shrink-0 w-[100px]">{{ $t('setting.top_p') }} </span>
        <div class="flex-1">
          <NSlider v-model:value="top_p" :max="1" :min="0" :step="0.1" />
        </div>
        <span class="flex-shrink-0 w-[30px]">{{ top_p }}</span>
      </div>
      <div class="flex items-center space-x-4">
        <span class="flex-shrink-0 w-[100px]">{{ $t('setting.frequencyPenalty') }} </span>
        <div class="flex-1">
          <NSlider v-model:value="frequency_penalty" :max="2" :min="-2" :step="0.1" />
        </div>
        <span class="flex-shrink-0 w-[30px]">{{ frequency_penalty }}</span>
      </div>
      <div class="flex items-center space-x-4">
        <span class="flex-shrink-0 w-[100px]">{{ $t('setting.presencePenalty') }} </span>
        <div class="flex-1">
          <NSlider v-model:value="presence_penalty" :max="2" :min="-2" :step="0.1" />
        </div>
        <span class="flex-shrink-0 w-[30px]">{{ presence_penalty }}</span>
      </div>
      <div class="flex items-center justify-center space-x-4 ">
        <NButton size="small" @click="updateSettings({ temperature, top_p, frequency_penalty, presence_penalty })">
          {{ $t('common.save') }}
        </NButton>
        <NButton size="small" @click="handleReset">
          {{ $t('common.reset') }}
        </NButton>
      </div>
    </div>
  </div>
</template>
