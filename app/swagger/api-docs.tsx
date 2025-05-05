import dynamic from 'next/dynamic';

const SwaggerUIComponent = dynamic(() => import('@/components/SwaggerUIComponent'), {
  ssr: false,
});

export default function SwaggerPage() {
  return <SwaggerUIComponent />;
}
