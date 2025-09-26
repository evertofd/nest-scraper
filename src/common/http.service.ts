import { Injectable } from '@nestjs/common';
import axios, { AxiosResponse } from 'axios';

const USER_AGENTS = [
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
];

const PROXIES = [
    'http://162.238.123.152:8888',
    'http://143.198.147.156:8888',
    'http://200.174.198.158:8888'
];

@Injectable()
export class HttpClientService {

    async get(url: string, useProxy: boolean = false): Promise<AxiosResponse> {
        const config: any = {
            headers: { 'User-Agent': this.getRandomUserAgent() },
            timeout: 10000
        };

        if (useProxy && PROXIES.length > 0) {
            const proxy = this.getRandomProxy();
            config.proxy = this.parseProxy(proxy);
            console.log(`Proxy: ${proxy}`);
        }

        await this.randomDelay();

        return await axios.get(url, config);
    }

    private getRandomUserAgent(): string {
        return USER_AGENTS[Math.floor(Math.random() * USER_AGENTS.length)];
    }

    private getRandomProxy(): string {
        return PROXIES[Math.floor(Math.random() * PROXIES.length)];
    }

    private parseProxy(proxyUrl: string) {
        const url = new URL(proxyUrl);
        return { host: url.hostname, port: parseInt(url.port) };
    }

    private async randomDelay(): Promise<void> {
        const delay = Math.random() * 3000 + 2000;
        await new Promise(resolve => setTimeout(resolve, delay));
    }
}