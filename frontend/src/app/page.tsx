import HeadNav from '@/components/headnav';
import { MdAnnouncement } from 'react-icons/md';

export default function Home() {
  return (
    <main>
      <HeadNav />
      <div className="container mx-auto p-1">
        <div className="flex w-full justify-between p-4 mt-40">
          <div className="mx-auto flex items-center">
            <p className="flex items-center text-sm font-normal text-gray-500 dark:text-gray-400">
              <MdAnnouncement className="mr-4 h-4 w-4" />
              <span className="[&_p]:inline">
                Marketplace Test Apps v0.1.0&nbsp;
                <a
                  href="#"
                  className="inline font-medium text-cyan-600 underline decoration-solid underline-offset-2 hover:no-underline dark:text-cyan-500"
                >
                  Github Repository
                </a>
              </span>
            </p>
          </div>
        </div>
      </div>
    </main>
  );
}
