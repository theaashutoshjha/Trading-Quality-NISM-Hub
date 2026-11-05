declare module 'page-flip' {
  export class PageFlip {
    constructor(element: HTMLElement, settings: Record<string, unknown>);
    loadFromHTML(items: HTMLElement[]): void;
    on(event: string, cb: (e: any) => void): PageFlip;
    flipNext(corner?: string): void;
    flipPrev(corner?: string): void;
    turnToPage(page: number): void;
    getPageCount(): number;
    destroy(): void;
  }
}

declare module '*?url' { const url: string; export default url; }
