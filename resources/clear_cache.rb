#
# Cookbook:: nscd
# resource:: clear_cache
#
# Copyright:: 2015-2016, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

property :databases, Array, default: %w(passwd group hosts services netgroup)

action :clear do
  new_resource.databases.each do |cmd|
    execute "nscd-clear-#{cmd}" do
      command "/usr/sbin/nscd -i #{cmd}"
      action :run
    end
  end
end
