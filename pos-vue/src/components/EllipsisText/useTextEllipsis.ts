import { ref, onMounted, onUpdated, nextTick } from 'vue';

export function useTextEllipsis() {
  const isOverflow = ref(false);
  const textRef = ref<HTMLElement>();

  const checkOverflow = async () => {
    await nextTick();
    const timer = setTimeout(() => {
      if (textRef.value) {
        isOverflow.value = textRef.value.scrollWidth > textRef.value.offsetWidth;
        clearTimeout(timer);
      }
    }, 0);
  };

  onMounted(checkOverflow);
  onUpdated(checkOverflow);

  return {
    textRef,
    isOverflow,
    checkOverflow,
  };
}
