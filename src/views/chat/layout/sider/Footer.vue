<script setup lang='ts'>
import { defineAsyncComponent, ref } from 'vue'
import { HoverButton, SvgIcon, UserAvatar } from '@/components/common'

const Login = defineAsyncComponent(() => import('@/components/common/Login/index.vue'))

const Setting = defineAsyncComponent(() => import('@/components/common/Setting/index.vue'))

const showLogin = ref(false)

const showSetting = ref(false)
</script>

<template>
  <footer class="flex items-center justify-between min-w-0 p-4 overflow-hidden border-t dark:border-neutral-800">
    <div class="flex-1 flex-shrink-0 overflow-hidden">
      <UserAvatar
        @click="showLogin = true"
      />
    </div>

    <HoverButton @click="showSetting = true">
      <span class="text-xl text-[#4f555e] dark:text-white">
        <SvgIcon icon="ri:settings-4-line" />
      </span>
    </HoverButton>

    <Login v-if="showLogin" v-model:visible="showLogin" />

    <Setting v-if="showSetting" v-model:visible="showSetting" />
  </footer>
</template>
