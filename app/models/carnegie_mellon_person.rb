class CarnegieMellonPerson < ActiveLdap::Base
  ldap_mapping :dn_attribute => "guid",
               :prefix => "ou=AndrewPerson",
               :classes => ["cmuAccountPerson"]

  include Gravtastic
  gravtastic secure: true, size: 48, rating: 'G', default: 'identicon'

  def self.find_by_andrewid( andrewid )
    
    begin
      person = find("cmuAndrewId=#{andrewid}", :attributes => ['cmuAndrewId',
                                                               'cn', 
                                                               'mail',
                                                               'sn',
                                                               'givenName',
                                                               'nickname',
                                                               'cmuDepartment',
                                                               'cmuStudentClass'
                                                              ]) 

      if person['cmuDepartment'].is_a? Array
        person['cmuDepartment'] = person['cmuDepartment'].join(', ')
      end

      return person unless person[:cn] == "Merged Person"
    rescue => e
      logger.error e
      return nil
    end
  end

  def all_names
    begin
      if self['nickname']
        return "#{self['sn']}, #{self['nickname']} (#{self['givenName']})"
      else
        return "#{self['sn']}, #{self['givenName']}"
      end
    rescue
      return ''
    end
  end

  private

    def email
      return self['mail']
    end

end
