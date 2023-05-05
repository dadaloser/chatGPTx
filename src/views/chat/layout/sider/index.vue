<script setup lang='ts'>
import type { CSSProperties } from 'vue'
import { computed, ref, watch } from 'vue'
import { NButton, NLayoutSider } from 'naive-ui'
import List from './List.vue'
import Footer from './Footer.vue'
import { useScroll } from '@/views/chat/hooks/useScroll'
import { useAppStore, useChatStore } from '@/store'
import { useBasicLayout } from '@/hooks/useBasicLayout'
import { PromptStore } from '@/components/common'
import { debounce } from '@/utils/functions/debounce'
import add_chat from '@/assets/add_chat.svg'

const { scrollRef, scrollToTop } = useScroll()

const appStore = useAppStore()
const chatStore = useChatStore()

const { isMobile } = useBasicLayout()
const show = ref(false)

const collapsed = computed(() => appStore.siderCollapsed)

const handleDeleteDebounce = debounce(clearAllChat, 600)

function handleAddNewChat() {
  // 滚动到顶部
  scrollToTop()

  chatStore.addHistory({ title: 'New Chat', uuid: Date.now(), isEdit: false })
  // 不需要点击后关闭
  // if (isMobile.value)
  //  appStore.setSiderCollapsed(true)
}

// 清除所有的聊天对话框
function clearAllChat() {
  chatStore.$state.history.forEach((element, index) => {
    chatStore.deleteHistory(index)
  })
  chatStore.$state.history.splice(0, chatStore.$state.history.length)
  // 移除所有的缓存记录
  // localStorage.removeItem('chatStorage')

  // 添加一个新的对话框
  handleAddNewChat()
}

function handleUpdateCollapsed() {
  appStore.setSiderCollapsed(!collapsed.value)
}

const getMobileClass = computed<CSSProperties>(() => {
  if (isMobile.value) {
    return {
      position: 'fixed',
      zIndex: 50,
    }
  }
  return {}
})

const mobileSafeArea = computed(() => {
  if (isMobile.value) {
    return {
      paddingBottom: 'env(safe-area-inset-bottom)',
    }
  }
  return {}
})

// 监控布局
watch(
  isMobile,
  (val) => {
    appStore.setSiderCollapsed(val)
  },
  {
    immediate: true,
    flush: 'post',
  },
)
</script>

<template>
  <NLayoutSider
    :collapsed="collapsed"
    :collapsed-width="0"
    :width="260"
    :show-trigger="isMobile ? false : 'bar'"
    collapse-mode="transform"
    position="absolute"
    bordered
    :style="getMobileClass"
    @update-collapsed="handleUpdateCollapsed"
  >
    <div class="flex flex-col h-full" :style="mobileSafeArea">
      <main class="flex flex-col flex-1 min-h-0">
        <div class="flex p-4  justify-content-between space-x-2">
          <NButton class="flex-1 " dashed block @click="handleAddNewChat">
            <template #icon>
              <img :src="add_chat">
            </template>
            {{ $t('chat.newChatButton') }}
          </NButton>

          <NButton class="flex-1" dashed block @click="handleDeleteDebounce">
            <template #icon>
              <img :src="add_chat">
            </template>
            {{ $t('chat.clearAll') }}
          </NButton>
        </div>

        <div id="scrollRef" ref="scrollRef" class="h-full overflow-hidden overflow-y-auto">
          <div class="flex-1 min-h-0 pb-4 overflow-hidden">
            <List />
          </div>
        </div>
        <div class="p-4">
          <NButton block @click="show = true">
            {{ $t('store.siderButton') }}
          </NButton>
        </div>
      </main>
      <Footer />
    </div>
  </NLayoutSider>
  <template v-if="isMobile">
    <div v-show="!collapsed" class="fixed inset-0 z-40 w-full h-full bg-black/40" @click="handleUpdateCollapsed" />
  </template>
  <PromptStore v-model:visible="show" />
</template>
