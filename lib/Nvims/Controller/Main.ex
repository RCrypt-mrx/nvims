defmodule Nvims.Controller.Main do
  require Logger

  @directories %{
    infrastructures: "/opt/nvims/infrastructures",
    vdisks: "/opt/nvims/vdisks"
  }

  def load() do
    Enum.each(@directories, fn {key, path} ->
      unless File.exists?(path) do
        Logger.info("#{key} directory not found, creating in #{path}...")
        File.mkdir!(path)
      else
        Logger.info("#{key} directory found")
      end
    end)

    # unless File.exists?(ovsifup) do
    #   File.touch!(ovsifup)
    #   File.write!(ovsifup, """
    #   #!/bin/sh
    #   switch=switch_name
    #   ip link set $1 up
    #   ovs-vsctl add-port ${switch} $1
    #   """)
    # end
    # unless File.exists?(ovsifdown) do
    #   File.touch!(ovsifdown)
    #   File.write!(ovsifdown, """
    #   #!/bin/sh
    #   switch=switch_name
    #   ip addr flush dev $1
    #   ip link set $1 down
    #   ovs-vsctl del-port ${switch} $1
    #   """)
    # end

    ts_define_tables()
    ts_sync_disk_files()
  end

  defp ts_define_tables() do
    {:ok, :nvims_main} = :dets.open_file(:nvims_main, [type: :set])
    :nvims_processes = :ets.new(:nvims_processes, [:set, :public, :named_table])

    # vmprocess

    # vmachine
    # vswitch
    # vport
    # vdisk
    # save
    # infrastructure
  end

  defp ts_sync_disk_files() do
    vdisks_ts = :dets.lookup(:nvims_main, "vdisk")
    infrastructures_ts = :dets.lookup(:nvims_main, "infrastructure")

    vdisks_exist = File.ls!(@directories[:vdisks])

    Enum.each(vdisks_exist, fn infrastructure_uuid ->
      if Enum.find_value(infrastructures_ts, fn uuid -> infrastructure_uuid == uuid end) do
        if String.length(infrastructure_uuid) == 36 do
          Logger.info("Found existing infrastructure #{infrastructure_uuid}")

          Enum.each(File.ls!("#{@directories[:vdisks]}/#{infrastructure_uuid}"), fn vdisk_file_name ->
            if String.ends_with?(vdisk_file_name, ".qcow2") && String.length(vdisk_file_name) == 36 do
              vdisk_uuid = String.trim(vdisk_file_name, ".qcow2")

              if Enum.find_value(vdisks_ts, fn uuid -> vdisk_uuid == uuid end) do
                Logger.info("Found existing vdisk #{vdisk_uuid} of infrastructure #{infrastructure_uuid}")
              else
                Logger.info("Added new vdisk #{vdisk_uuid} of infrastructure #{infrastructure_uuid}")

                # qemu-img info to found maxsize
                true = :dets.insert(:nvims_main, {"vdisk", vdisk_uuid, vdisk_uuid, 30000, []})
              end
            end
          end)
        end
      else
        Logger.warn("Illegal directory #{@directories[:vdisks]}/#{infrastructure_uuid}. Remove it NOW!")
      end
    end)
  end
end
